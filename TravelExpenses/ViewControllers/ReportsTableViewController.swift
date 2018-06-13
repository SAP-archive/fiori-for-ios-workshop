//
//  ReportsTableViewController.swift
//  TravelExpenseApp
//
//  Created by Stadelman, Stan on 2/23/18.
//  Copyright © 2018 Stadelman, Stan. All rights reserved.
//

import SAPFiori
import SAPOData
import UIKit

class ReportsTableViewController: FioriBaseTableViewController {
    
    // MARK: - Model
    
    var expenseReports: [ExpenseReportItemType] = [] {
        didSet {
            self.activeExpenseReports = expenseReports.filter { $0.reportstatusid == "ACT" }
            self.tableView.reloadData()
        }
    }

    private(set) var activeExpenseReports: [ExpenseReportItemType] = []

    // MARK: View controller hooks
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let addButton = UIBarButtonItem(image: FUIIconLibrary.system.create.withRenderingMode(.alwaysTemplate), landscapeImagePhone: nil, style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItems = [addButton]
        self.navigationItem.title = "Expense Reports"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let nestedQuery = DataQuery().expand(ExpenseItemType.currency, ExpenseItemType.expenseType, ExpenseItemType.paymentType)
        let query = DataQuery().expand(ExpenseReportItemType.expenseItems, withQuery: nestedQuery)
        
        DataHandler.shared.service.fetchExpenseReportItem(matching: query) { [weak self] (entities, error) in
            guard let entities = entities else {
                return print(String(describing: error))
            }
            self?.expenseReports = entities
        }
    }

    @objc func toggleEditing() {
        self.setEditing(!self.isEditing, animated: true)
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in _: UITableView) -> Int {
        return 2
    }

    override func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.activeExpenseReports.count
        case 1:
            return self.expenseReports.count - self.activeExpenseReports.count
        default:
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0, 1:
            let report = indexPath.section == 0 ? activeExpenseReports[indexPath.row] : expenseReports[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: FUIObjectTableViewCell.reuseIdentifier, for: indexPath) as! FUIObjectTableViewCell
            cell.headlineText = report.reportname
            cell.footnoteText = report.reportlocation
            cell.subheadlineText = report.rangeString()
            cell.accessoryType = .disclosureIndicator
            if let statusId = report.reportstatusid {
                switch statusId {
                case "ACT":
                    cell.statusText = nil
                case "PND":
                    cell.statusText = "Pending"
                    cell.statusLabel.textColor = UIColor.preferredFioriColor(forStyle: .critical)
                default:
                    cell.statusText = "Approved"
                    cell.statusLabel.textColor = UIColor.preferredFioriColor(forStyle: .positive)
                }
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: FUITextFieldFormCell.reuseIdentifier, for: indexPath) as! FUITextFieldFormCell
            cell.keyLabel.text = "All Reports"
            cell.value = "\(expenseReports.count)"
            cell.accessoryType = .disclosureIndicator
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: FUITableViewHeaderFooterView.reuseIdentifier) as! FUITableViewHeaderFooterView
        view.backgroundView = UIView()
        view.backgroundView?.backgroundColor = UIColor.white
        view.isUserInteractionEnabled = false

        switch section {
        case 0:
            view.titleLabel.text = "Active"
        case 1:
            view.titleLabel.text = "Submitted"
        default:
            return nil
        }
        return view
    }

    // MARK: - Table view delegate
    
    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section < 2 else { return }

        let report = indexPath.section == 0 ? activeExpenseReports[indexPath.row] : expenseReports[indexPath.row]

        let reportDetail = ReportDetailsTableViewController(style: .grouped)
        reportDetail.setReport(report)
        self.navigationController?.pushViewController(reportDetail, animated: true)
    }
}
