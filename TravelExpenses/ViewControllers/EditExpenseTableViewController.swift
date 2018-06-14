//
//  EditExpenseTableViewController.swift
//  TravelExpenseApp
//
//  Created by Stadelman, Stan on 2/23/18.
//  Copyright © 2018 SAP SE or an SAP affiliate company. All rights reserved.
//

import SAPFiori
import SAPOData
import UIKit

class EditExpenseTableViewController: UITableViewController {
    
    // MARK: - Model
    
    var attachmentURLs: [URL] = [URL]()
    
    // MARK: View controller hooks
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(FUIKeyValueFormCell.self, forHeaderFooterViewReuseIdentifier: FUIKeyValueFormCell.reuseIdentifier)
    }

    // MARK: - Table view data source

    override func numberOfSections(in _: UITableView) -> Int {
        return 2
    }

    override func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 7
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FUIKeyValueFormCell.reuseIdentifier, for: indexPath) as! FUIKeyValueFormCell
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell.keyName = "Expense Type"
                cell.value = "Airfare"
            case 1:
                cell.keyName = "Vendor"
                cell.value = "Delta Airlines"
            case 2:
                cell.keyName = "Transaction Date"
                cell.value = "09/05/2017"
            case 3:
                cell.keyName = "Location"
                cell.value = "Palo Alto, CA"
            case 4:
                cell.keyName = "Amount"
                cell.value = "126.40"
            case 5:
                cell.keyName = "Currency"
                cell.value = "USD"
            default:
                cell.keyName = "Payment"
                cell.value = "Company paid"
            }
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: FUIAttachmentsFormCell.reuseIdentifier, for: indexPath) as! FUIAttachmentsFormCell

            //            cell.attachmentsController.delegate = self
            //            cell.attachmentsController.dataSource = self
            return cell
        }

        return cell
    }

}
