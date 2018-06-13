//
//  EntityTypePickerDataSource.swift
//  TravelExpenses
//
//  Created by Stadelman, Stan on 6/11/18.
//  Copyright © 2018 SAP. All rights reserved.
//

import Foundation
import SAPOData

protocol EntityTypePickerDataSource {
    
    associatedtype EntityType: EntityValue & PickableEntityType
    var entities: [EntityType] { get set }
    func entity(at index: Int) -> EntityType 
    func entity(with uniqueIdentifier: String) -> EntityType
    
}

extension EntityTypePickerDataSource {
    // Utility method, which abstracts selection of the entity at index from the `entities` collection, or, if `SearchableEntityTypePickerDataSource` is implemented, the `filteredEntities` collection.
    func entity(at index: Int) -> EntityType {
        guard (0..<entities.count).contains(index) else {
            preconditionFailure("Out of range")
        }
        return entities[index]
    }
    
    // Utility method,
    func entity(with uniqueIdentifier: String) -> EntityType {
        guard let entity = entities.filter({ $0.pickerUUID == uniqueIdentifier }).first else {
            preconditionFailure("no entity found with unique identifier of \(uniqueIdentifier)")
        }
        return entity
    }
}

/// MARK: - Utility methods
extension EntityTypePickerDataSource {
    
    func singleEntity(for pickerValue: [Int]) -> EntityType? {
        guard let index = pickerValue.first else {
            return nil
        }
        return self.entity(at: index)
    }
    
    func singleEntity(for pickerValue: [String]) -> EntityType? {
        
        guard let uuid = pickerValue.first else {
            return nil
        }
        return self.entity(with: uuid)
    }
}


/*
 Placeholder
protocol SearchableEntityTypePickerDataSource: EntityTypePickerDataSource {
    var filteredEntities: [EntityType] { get set }
    var isFiltered: Bool { get set }
    var searchFilter: ((EntityType) -> Bool)? { get }
}
 */

