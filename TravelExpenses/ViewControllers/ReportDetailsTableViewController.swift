//
//  ReportDetailsTableViewController.swift
//  TravelExpenseApp
//
//  Created by Stadelman, Stan on 2/23/18.
//  Copyright © 2018 SAP SE or an SAP affiliate company. All rights reserved.
//

import UIKit
import SAPFiori
import SAPOData

class ReportDetailsTableViewController: FioriBaseTableViewController {
    
    // MARK: - Model
    
    private var report: ExpenseReportItemType!

    func setReport(_ report: ExpenseReportItemType) {
        self.report = report
        
        self.objectHeader.headlineText = report.reportname
        self.objectHeader.subheadlineText = report.reportid
        self.objectHeader.tags = ["Active", "Not Customer Facing"].map({
            FUITag(title: $0)
        })
        self.objectHeader.bodyText = report.reportlocation
        self.objectHeader.footnoteText = report.rangeString()
    }

    // Hack: in Grouped table view mode, init the Object Header with a non-zero height, to prevent content offset adjustment https://stackoverflow.com/questions/18880341/why-is-there-extra-padding-at-the-top-of-my-uitableview-with-style-uitableviewst?page=2&tab=votes#comment54066953_18880341
    let objectHeader = FUIObjectHeader(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude))
    
    private var addButton: UIBarButtonItem!


    // MARK: View controller hooks
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(FUIKeyValueFormCell.self, forCellReuseIdentifier: FUIKeyValueFormCell.reuseIdentifier)
        self.tableView.tableHeaderView = self.objectHeader
        self.tableView.allowsSelectionDuringEditing = false

        addButton = UIBarButtonItem(image: FUIIconLibrary.system.create.withRenderingMode(.alwaysTemplate), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(addExpense))
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(self.toggleEditing))
        self.navigationItem.rightBarButtonItems = [editButton, addButton]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // handle case where screen was visible, but user created new expense on "Expenses" tab.
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
            return self.report.expenseItems.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            let cell = tableView.dequeueReusableCell(withIdentifier: FUIKeyValueFormCell.reuseIdentifier, for: indexPath) as! FUIKeyValueFormCell
            cell.keyName = "Report Total"
            let totalAmt: Double = report.expenseItems.reduce(0) { $0 + $1.amount!.doubleValue() }
            cell.value = NumberFormatter(.currency).string(from: totalAmt as NSNumber)!
            cell.isEditable = false

            return cell
        case (0, 1):
            let cell = tableView.dequeueReusableCell(withIdentifier: FUIKeyValueFormCell.reuseIdentifier, for: indexPath) as! FUIKeyValueFormCell
            cell.keyName = "Amount Due Employee"
            let dueAmt: Double = report.expenseItems.filter({ $0.paymenttypeid == "EMP" }).reduce(0) { $0 + $1.amount!.doubleValue() }
            cell.value = NumberFormatter(.currency).string(from: dueAmt as NSNumber)!
            cell.isEditable = false
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: FUIObjectTableViewCell.reuseIdentifier, for: indexPath) as! FUIObjectTableViewCell
            cell.preserveIconStackSpacing = true
            let expense = report.expenseItems[indexPath.row]
            cell.iconImages = expense.iconImages()
            cell.headlineText = expense.vendor
            if let date = expense.itemdate {
                cell.subheadlineText = DateFormatter(.medium).string(from: date.utc())
            }
            if let source = expense.paymenttypeid {
                switch source {
                case "EMP":
                    cell.footnoteText = "Employee paid"
                case "COM":
                    cell.footnoteText = "Company paid"
                case "AAA":
                    cell.footnoteText = "AAA-paid"
                default:
                    break
                }
            }
            cell.statusText = NumberFormatter(.currency).string(from: expense.amount!.doubleValue() as NSNumber)
            return cell
        }
    }
    
    override func tableView(_: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section > 0
    }

    // MARK: - Table view delegate
    
    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section > 0 else { return }
        let expense = report.expenseItems[indexPath.row]
        let detailViewController = ExpenseDetailTableViewController(style: .grouped)
        detailViewController.setExpense(expense)
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    // MARK: - Support deleting Expense items
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let entity = self.report.expenseItems[indexPath.row]
        
        DataHandler.shared.service.deleteEntity(entity, completionHandler: { [weak self] error in
            guard error == nil else {
                let errorBanner = FUIBannerMessageView()
                self?.objectHeader.bannerView = errorBanner
                errorBanner.show(message: "Failed to delete expense item", withDuration: 4.0, animated: true)
                return
            }
            
            self?.tableView.beginUpdates()
            self?.report.expenseItems.remove(at: indexPath.row)
            self?.tableView.deleteRows(at: [indexPath], with: .automatic)
            self?.tableView.endUpdates()
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
            self.navigationItem.rightBarButtonItems?.append(addButton)
        }
    }
    
    @objc func addExpense() {
        let vc = CreateExpenseTableViewController(style: .grouped)
        vc.expense.reportid = self.report.reportid
        let navigationController = UINavigationController(rootViewController: vc)
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
    
    func reloadExpenseItems() {
        let query = DataQuery().orderBy(ExpenseItemType.itemdate)
        DataHandler.shared.service.loadProperty(ExpenseReportItemType.expenseItems, into: self.report, query: query) { [weak self] (error) in
            guard error == nil else {
                return print(error!)
            }
            self?.tableView.reloadData()
        }
    }
}
