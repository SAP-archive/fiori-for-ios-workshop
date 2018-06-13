//
//  ReportDetailsTableViewController.swift
//  TravelExpenseApp
//
//  Created by Stadelman, Stan on 2/23/18.
//  Copyright © 2018 Stadelman, Stan. All rights reserved.
//

import SAPFiori
import UIKit

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

    let objectHeader = FUIObjectHeader()

    // MARK: View controller hooks
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(FUIKeyValueFormCell.self, forCellReuseIdentifier: FUIKeyValueFormCell.reuseIdentifier)
        self.tableView.tableHeaderView = self.objectHeader
        self.tableView.allowsSelectionDuringEditing = false

        let addButton = UIBarButtonItem(image: FUIIconLibrary.system.create.withRenderingMode(.alwaysTemplate), landscapeImagePhone: nil, style: .plain, target: self, action: nil)
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(self.toggleEditing))
        self.navigationItem.rightBarButtonItems = [editButton, addButton]
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
            let dueAmt: Double = report.expenseItems.filter({ $0.expenseType?.expensetypeid == "EMP" }).reduce(0) { $0 + $1.amount!.doubleValue() }
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
            cell.footnoteText = "Employee Paid"
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

    // MARK: - Actions

    @objc func toggleEditing() {
        self.setEditing(!self.isEditing, animated: true)
    }
}
