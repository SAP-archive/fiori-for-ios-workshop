//
//  MyOverviewFloorplan.swift
//  TravelExpenses
//
//  Created by Stadelman, Stan on 6/14/18.
//  Copyright © 2018 SAP. All rights reserved.
//

import UIKit
import SAPFiori
import SAPOData
import SAPOfflineOData

class MyOverviewFloorplan: UITableViewController {

    // MARK: - Model
    
    var expenseItems: [ExpenseItemType] = []
    
    var dataService: Travelexpense<OfflineODataProvider>!
    let dataQuery = DataQuery().expand(ExpenseItemType.paymentType)
    
    // MARK: - View controller hooks
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 84
        self.tableView.register(FUIObjectTableViewCell.self, forCellReuseIdentifier: FUIObjectTableViewCell.reuseIdentifier)
        
        self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        self.tableView.estimatedSectionHeaderHeight = 30
        self.tableView.register(FUITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: FUITableViewHeaderFooterView.reuseIdentifier)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        dataService = appDelegate.travelexpense
        
        dataService?.fetchExpenseItem(matching: dataQuery) { [weak self] expenses, error in
            guard let expenses = expenses else {
                return print(String(describing: error.debugDescription))
            }
            self?.expenseItems = expenses
            self?.tableView.reloadData()
        }
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return expenseItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let expense = expenseItems[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FUIObjectTableViewCell.reuseIdentifier, for: indexPath) as! FUIObjectTableViewCell
        cell.headlineText = expense.vendor ?? " - "
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        
        if let amount = expense.amount?.doubleValue() {
            cell.statusText = numberFormatter.string(from: amount as NSNumber)
        }
        
        cell.footnoteText = expense.paymentType?.description
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: FUITableViewHeaderFooterView.reuseIdentifier) as! FUITableViewHeaderFooterView
        view.titleLabel.text = "Active Expenses"
        return view
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let entity = self.expenseItems[indexPath.row]
        
        do {
            try self.dataService.deleteEntity(entity)
        }
        catch {
            print(String(describing: error))
        }
        
        self.tableView.beginUpdates()
        self.expenseItems.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .fade)
        self.tableView.endUpdates()
        
        if let vendor = entity.vendor {
            FUIToastMessage.show(message: "Expense at: \(vendor) deleted")
        }
    }
}
