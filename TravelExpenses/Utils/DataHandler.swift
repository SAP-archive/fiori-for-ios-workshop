//
//  DataHandler.swift
//  SAP-Expense
//
//  Created by Stadelman, Stan on 4/3/18.
//  Copyright © 2018 SAP SE or an SAP affiliate company.  All rights reserved.
//

import Foundation
import SAPOData
import SAPOfflineOData

/// Helper singleton, for accessing DataService from background threads
class DataHandler {
    static let downloadCompleteNotification = Notification.Name("com.sap.travelexpense.offline.downloadcomplete")
    static let shared = DataHandler()
    private init() {}
    var service: Travelexpense<OfflineODataProvider>!
}
