//
//  BaseEntityTypePickerDataSource.swift
//  TravelExpenses
//
//  Created by Stadelman, Stan on 6/11/18.
//  Copyright © 2018 SAP. All rights reserved.
//

import UIKit
import SAPFiori
import SAPOData


class BaseEntityTypePickerDataSource<EntityType: EntityValue & PickableEntityType>: EntityTypePickerDataSource, FUIListPickerDataSource {
    
    var entities: [EntityType] = []
    
    // MARK: - FUIListPickerDataSource implementation
    func numberOfRows() -> Int {
        return entities.count
    }
    
    // The `PickableEntityType` constraint is added, so that `EntityValue` instances supply a convenient UUID, instead of just `EntityKey.toString()`
    func listPickerTableView(_ tableView: UITableView, uniqueIdentifierForItemAt index: Int) -> String {
        return entities[index].pickerUUID
    }
    
    // Using `FUIObjectTableViewCell` for convenience
    func listPickerTableView(_ tableView: UITableView, cellForRowAt index: Int, isFiltered: Bool) -> UITableViewCell {
        var cell: FUIObjectTableViewCell! = tableView.dequeueReusableCell(withIdentifier: FUIObjectTableViewCell.reuseIdentifier) as? FUIObjectTableViewCell
        if cell == nil {
            cell = FUIObjectTableViewCell()
        }
        return cell
    }
    
    /**
     Optional method, allowing us to support setting picker value by UUID.
     - important: Configuration of the cells should occur in `cellForRowAt index`, not here.  This default implementation is typically sufficient.
     */
    func listPickerTableView(_ tableView: UITableView, cellForItemWithUniqueIdentifier uniqueIdentifier: String) -> UITableViewCell {
        let index = self.listPickerTableView(tableView, indexForUniqueIdentifier: uniqueIdentifier)
        return listPickerTableView(tableView, cellForRowAt: index, isFiltered: false)
    }
    
    func listPickerTableView(_ tableView: UITableView, indexForUniqueIdentifier uniqueIdentifier: String) -> Int {
        guard let index = entities.index(where: { (entity) -> Bool in
            return entity.pickerUUID == uniqueIdentifier
        }) else {
            return -1
        }
        return index
    }

}


