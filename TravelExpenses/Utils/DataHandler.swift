//
//  DataHandler.swift
//  SAP-Expense
//
//  Created by Stadelman, Stan on 4/3/18.
//  Copyright © 2018 SAP. All rights reserved.
//

import Foundation
import SAPOData
import SAPOfflineOData


/// Helper singleton, for accessing DataService from background threads
class DataHandler {
    static let shared = DataHandler()
    private init() {}
}

/// TODO:  move to stored property on DataHandler, so AppDelegate is not accessed
extension DataHandler {
    var service: Travelexpense<OfflineODataProvider> {
        return (UIApplication.shared.delegate as! AppDelegate).travelexpense
    }
}

