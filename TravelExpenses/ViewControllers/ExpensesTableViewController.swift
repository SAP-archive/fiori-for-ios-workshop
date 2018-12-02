//
//  ExpensesTableViewController.swift
//  TravelExpenseApp
//
//  Created by Stadelman, Stan on 2/23/18.
//  Copyright © 2018 SAP SE or an SAP affiliate company. All rights reserved.
//

import SAPFiori
import SAPOData
import UIKit

class ExpensesTableViewController: FioriBaseTableViewController {

    // MARK: - Model

    var entities: [ExpenseItem] = [] {
        didSet {
            if self.entities != oldValue {
                self.tableView.reloadData()
            }
        }
    }

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

        self.addButton = UIBarButtonItem(image: FUIIconLibrary.system.create.withRenderingMode(.alwaysTemplate), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(self.addExpense))
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(self.toggleEditing))
        self.navigationItem.rightBarButtonItems = [editButton, addButton]
        
        downloadCompleteObserver = NotificationCenter.default.addObserver(forName: DataHandler.downloadCompleteNotification, object: nil, queue: .main) { [unowned self] _ in
            self.reloadExpenseItems()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationItem.title = "Expense Reports"

        self.reloadExpenseItems()
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
        if let _ = item.amount {
            cell.statusText = nf.string(from: item.localCurrencyAmount() as NSNumber)
        }
        cell.accessoryType = .disclosureIndicator

        return cell
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: FUITableViewHeaderFooterView.reuseIdentifier) as! FUITableViewHeaderFooterView
        switch section {
        case 0:
            view.titleLabel.text = "Unreported Expenses"
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

    // MARK: - Support deleting Expense items

    override func tableView(_: UITableView, commit _: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let entity = self.entities[indexPath.row]

        DataHandler.shared.service.deleteEntity(entity, completionHandler: { [weak self] error in
            guard error == nil else {
                if let navigationBar = self?.navigationController?.navigationBar as? FUINavigationBar {
                    navigationBar.bannerView?.show(message: "Failed to delete expense item", withDuration: 4.0, animated: true)
                }
                return
            }

            self?.tableView.beginUpdates()
            self?.entities.remove(at: indexPath.row)
            self?.tableView.deleteRows(at: [indexPath], with: .automatic)
            self?.tableView.endUpdates()
        })
    }

    // MARK: - Actions

    func reloadExpenseItems() {
        
        let query = DataQuery()
            .filter(ExpenseReportItem.reportstatusid == "ACT")
            .expand(ExpenseReportItem.expenseItems, withQuery: DataQuery()
                .expand(ExpenseItem.currency, ExpenseItem.expenseType, ExpenseItem.paymentType, ExpenseItem.attachments))
        
        
        DataHandler.shared.service.fetchExpenseReports (matching: query) { [weak self] items, error in
            guard let entities = items else {
                return print(String(describing: error.debugDescription))
            }
            
            self?.entities = entities.flatMap { $0.expenseItems }
        }
    }
    
    @objc func toggleEditing() {
        self.setEditing(!self.isEditing, animated: true)
        if isEditing, let index = self.navigationItem.rightBarButtonItems?.index(of: addButton) {
            self.navigationItem.rightBarButtonItems?.remove(at: index)
        } else {
            self.navigationItem.rightBarButtonItems?.append(self.addButton)
        }
    }

    @objc func addExpense() {
        let vc = CreateExpenseTableViewController(style: .grouped)
        let navigationController = UINavigationController(rootViewController: vc)
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
}
