//
//  ExpensesTableViewController.swift
//  TravelExpenseApp
//
//  Created by Stadelman, Stan on 2/23/18.
//  Copyright © 2018 Stadelman, Stan. All rights reserved.
//

import SAPFiori
import SAPOData
import UIKit

class ExpensesTableViewController: FioriBaseTableViewController {

    // MARK: - Model
    
    var entities: [ExpenseItemType] = [] {
        didSet {
            if self.entities != oldValue {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: View controller hooks

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.allowsMultipleSelectionDuringEditing = true

        let addButton = UIBarButtonItem(image: FUIIconLibrary.system.create.withRenderingMode(.alwaysTemplate), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(self.addExpense))
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(self.toggleEditing))
        self.navigationItem.rightBarButtonItems = [editButton, addButton]

        self.navigationItem.title = "Expense Reports"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let query = DataQuery().expand(ExpenseItemType.currency, ExpenseItemType.expenseType, ExpenseItemType.paymentType)
        DataHandler.shared.service.fetchExpenseItem(matching: query) { [weak self] (items, error) in
            guard let entities = items else {
                return print(String(describing: error.debugDescription))
            }
            self?.entities = entities.filter { $0.reportid == nil }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return self.entities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FUIObjectTableViewCell.reuseIdentifier, for: indexPath) as! FUIObjectTableViewCell

        let item = entities[indexPath.row]

        let df = DateFormatter()
        df.dateStyle = .medium

        let nf = NumberFormatter()
        nf.numberStyle = .currency

        cell.preserveIconStackSpacing = true
        cell.iconImages = item.iconImages()
        cell.headlineLabel.text = item.vendor
        if let date = item.itemdate {
            cell.subheadlineText = df.string(from: date.utc())
        }
        cell.footnoteText = item.paymentType?.description
        if let amount = item.amount {
            cell.statusText = nf.string(from: amount.doubleValue() as NSNumber)
        }
        cell.accessoryType = .disclosureIndicator

        return cell
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: FUITableViewHeaderFooterView.reuseIdentifier) as! FUITableViewHeaderFooterView
        switch section {
        case 0:
            view.titleLabel.text = "Unassigned Expenses"
        default:
            return nil
        }
        return view
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        let expense = entities[indexPath.row]
        let detailViewController = ExpenseDetailTableViewController(style: .grouped)
        detailViewController.setExpense(expense)
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    // MARK: - Actions
    
    @objc func toggleEditing() {
        self.setEditing(!self.isEditing, animated: true)
    }
    
    @objc func addExpense() {
        let vc = CreateExpenseTableViewController(style: .grouped)
        let navigationController = UINavigationController(rootViewController: vc)
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
}
