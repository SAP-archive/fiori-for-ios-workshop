//
//  CurrencyType+Extensions.swift
//  SAP-Expense
//
//  Created by Stadelman, Stan on 5/29/18.
//  Copyright © 2018 SAP. All rights reserved.
//

import UIKit
import SAPFiori
import SAPOData




extension FUIListPickerDataSource {

    func listPickerTableView(_ tableView: UITableView, cellForItemWithUniqueIdentifier uniqueIdentifier: String) -> UITableViewCell {
        let index = self.listPickerTableView!(tableView, indexForUniqueIdentifier: uniqueIdentifier)
        return listPickerTableView(tableView, cellForRowAt: index, isFiltered: false)
    }
}





