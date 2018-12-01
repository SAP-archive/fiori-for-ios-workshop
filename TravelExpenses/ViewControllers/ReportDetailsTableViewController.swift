//
//  ReportDetailsTableViewController.swift
//  TravelExpenseApp
//
//  Created by Stadelman, Stan on 2/23/18.
//  Copyright © 2018 SAP SE or an SAP affiliate company. All rights reserved.
//

import SAPFiori
import SAPOData
import UIKit

class ReportDetailsTableViewController: FioriBaseTableViewController {

    // MARK: - Model

    private var report: ExpenseReportItemType!

    func setReport(_ report: ExpenseReportItemType) {
        self.report = report
        setTags()
        self.objectHeader.headlineText = report.reportname
        self.objectHeader.subheadlineText = report.reportlocation
        self.objectHeader.bodyText = report.reportid
        self.objectHeader.footnoteText = report.rangeString()
    }
    
    func setTags() {
        let statusTag = FUITag(title: report.reportstatusid == "ACT" ? "Active" : "Pending")
        if report.reportstatusid == "PEN" {
            statusTag.textColor = UIColor.preferredFioriColor(forStyle: .critical, background: .light)
            statusTag.borderColor = UIColor.preferredFioriColor(forStyle: .critical, background: .dark)
        }
        self.objectHeader.tags = [statusTag, FUITag(title: "Not Customer Facing")]
        
    }
    
    var expenseItems: [ExpenseItemType] = []

    // Hack: in Grouped table view mode, init the Object Header with a non-zero height, to prevent content offset adjustment https://stackoverflow.com/questions/18880341/why-is-there-extra-padding-at-the-top-of-my-uitableview-with-style-uitableviewst?page=2&tab=votes#comment54066953_18880341
    let objectHeader = FUIObjectHeader(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude))

    private var addButton: UIBarButtonItem!

    // MARK: View controller hooks

    private var downloadCompleteObserver: Any?

    deinit {
        if let downloadCompleteObserver = downloadCompleteObserver {
            NotificationCenter.default.removeObserver(downloadCompleteObserver)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(FUIKeyValueFormCell.self, forCellReuseIdentifier: FUIKeyValueFormCell.reuseIdentifier)
        self.tableView.tableHeaderView = self.objectHeader
        self.tableView.allowsSelectionDuringEditing = false

        self.addButton = UIBarButtonItem(image: FUIIconLibrary.system.create.withRenderingMode(.alwaysTemplate), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(self.addExpense))
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(self.toggleEditing))
        self.navigationItem.rightBarButtonItems = [editButton, addButton]
        
        downloadCompleteObserver = NotificationCenter.default.addObserver(forName: DataHandler.downloadCompleteNotification, object: nil, queue: .main) { [unowned self] _ in
            self.reloadExpenseItems()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // handle case where screen was visible, but user created new expense on "Expenses" tab.
        self.reloadReport()
        self.reloadExpenseItems()
    }

    // MARK: - Table view data source

    override func numberOfSections(in _: UITableView) -> Int {
        return 2
    }

    override func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        default:
            return self.expenseItems.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            let cell = tableView.dequeueReusableCell(withIdentifier: FUIKeyValueFormCell.reuseIdentifier, for: indexPath) as! FUIKeyValueFormCell
            cell.keyName = "Report Total"
            let totalAmt: Double = expenseItems.reduce(0) { $0 + $1.localCurrencyAmount() }
            cell.value = NumberFormatter(.currency).string(from: totalAmt as NSNumber)!
            cell.isEditable = false

            return cell
        case (0, 1):
            let cell = tableView.dequeueReusableCell(withIdentifier: FUIKeyValueFormCell.reuseIdentifier, for: indexPath) as! FUIKeyValueFormCell
            cell.keyName = "Amount Due Employee"
            let dueAmt: Double = expenseItems.filter({ $0.paymenttypeid == "EMP" }).reduce(0) { $0 + $1.localCurrencyAmount() }
            cell.value = NumberFormatter(.currency).string(from: dueAmt as NSNumber)!
            cell.isEditable = false
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: FUIObjectTableViewCell.reuseIdentifier, for: indexPath) as! FUIObjectTableViewCell
            cell.preserveIconStackSpacing = true
            let expense = expenseItems[indexPath.row]
            cell.iconImages = expense.iconImages()
            cell.headlineText = expense.vendor
            if let date = expense.itemdate {
                cell.subheadlineText = DateFormatter(.medium).string(from: date.utc())
            }
            cell.footnoteText = expense.paymentType?.description
            cell.statusText = NumberFormatter(.currency).string(from: expense.localCurrencyAmount() as NSNumber)
            return cell
        }
    }

    override func tableView(_: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section > 0
    }

    // MARK: - Table view delegate

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section > 0 else { return }
        let expense = expenseItems[indexPath.row]
        let detailViewController = ExpenseDetailTableViewController(style: .grouped)
        detailViewController.setExpense(expense)
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }

    // MARK: - Support deleting Expense items

    override func tableView(_: UITableView, commit _: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let entity = self.expenseItems[indexPath.row]
        
        let changeSet = ChangeSet()
        if report.reportstatusid != "ACT" {
            report.reportstatusid = "ACT"
            changeSet.updateEntity(report)
        }

        changeSet.deleteEntity(entity)

        DataHandler.shared.service.applyChanges(changeSet, completionHandler: { [weak self] error in
            guard error == nil else {
                let errorBanner = FUIBannerMessageView()
                self?.objectHeader.bannerView = errorBanner
                errorBanner.show(message: "Failed to delete expense item", withDuration: 4.0, animated: true)
                return
            }

            self?.tableView.beginUpdates()
            self?.setTags()
            self?.expenseItems.remove(at: indexPath.row)
            self?.tableView.deleteRows(at: [indexPath], with: .automatic)
            self?.tableView.endUpdates()
            self?.tableView.reloadSections([0], with: .fade)
        })
    }

    // MARK: - Actions

    @objc func toggleEditing() {
        self.setEditing(!self.isEditing, animated: true)

        // If no longer editing, reload expense items set
        if !isEditing {
            self.reloadExpenseItems()
        }

        if isEditing, let index = self.navigationItem.rightBarButtonItems?.index(of: addButton) {
            self.navigationItem.rightBarButtonItems?.remove(at: index)
        } else {
            self.navigationItem.rightBarButtonItems?.append(self.addButton)
        }
    }

    @objc func addExpense() {
        let vc = CreateExpenseTableViewController(style: .grouped)
        vc.expense.reportid = self.report.reportid
        let navigationController = UINavigationController(rootViewController: vc)
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }

    func reloadReport() {
        let query = DataQuery().withKey(ExpenseReportItemType.key(reportid: report.reportid))
        DataHandler.shared.service.fetchExpenseReportItem(matching: query, completionHandler: { [weak self] reports, _ in
            guard let report = reports?.first else { return }
            self?.setReport(report)
        })
    }
    
    func reloadExpenseItems() {
        
        let query = DataQuery().filter(ExpenseItemType.reportid == report.reportid!).expand(ExpenseItemType.paymentType, ExpenseItemType.attachments).orderBy(ExpenseItemType.itemdate)
        
        DataHandler.shared.service.fetchExpenseItem(matching: query) { [weak self] items, error in
            guard let items = items, error == nil else {
                return print(error!)
            }
            self?.expenseItems = items
            self?.tableView.reloadData()
        }
    }
}
