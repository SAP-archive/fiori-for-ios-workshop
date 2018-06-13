//
//  Cache.swift
//  SAP-Expense
//
//  Created by Stadelman, Stan on 4/3/18.
//  Copyright © 2018 SAP. All rights reserved.
//

import Foundation
import SAPFoundation
import SAPOData
import SAPOfflineOData

class DataHandler {
    static let shared = DataHandler()
    private init() {}
}

extension DataHandler {

    var service: Travelexpense<OfflineODataProvider> {
        return (UIApplication.shared.delegate as! AppDelegate).travelexpense
    }
}

