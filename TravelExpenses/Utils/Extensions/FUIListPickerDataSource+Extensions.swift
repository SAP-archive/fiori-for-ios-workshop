//
//  CurrencyType+Extensions.swift
//  SAP-Expense
//
//  Created by Stadelman, Stan on 5/29/18.
//  Copyright © 2018 SAP SE or an SAP affiliate company.  All rights reserved.
//

import UIKit
import SAPFiori


/// Utility extension to map `indexForUniqueIdentifier` to `cellForRowAt`
extension FUIListPickerDataSource {

    func listPickerTableView(_ tableView: UITableView, cellForItemWithUniqueIdentifier uniqueIdentifier: String) -> UITableViewCell {
        let index = self.listPickerTableView!(tableView, indexForUniqueIdentifier: uniqueIdentifier)
        return listPickerTableView(tableView, cellForRowAt: index, isFiltered: false)
    }
}





