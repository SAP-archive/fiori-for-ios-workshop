//
//  OfflineODataStoreState+Description.swift
//  SAP-Expense
//

import Foundation
import SAPOfflineOData

// Adds a string description property to the Offline OData store state option set.
extension OfflineODataStoreState: CustomStringConvertible {
    public var description: String {
        var stateDescriptions: [String] = []
        if contains(.opening) { stateDescriptions.append("opening") }
        if contains(.open) { stateDescriptions.append("open") }
        if contains(.closed) { stateDescriptions.append("closed") }
        if contains(.downloading) { stateDescriptions.append("downloading") }
        if contains(.uploading) { stateDescriptions.append("uploading") }
        if contains(.initializing) { stateDescriptions.append("initializing") }
        if contains(.fileDownloading) { stateDescriptions.append("fileDownloading") }
        if contains(.initialCommunication) { stateDescriptions.append("initialCommunication") }
        return stateDescriptions.joined(separator: ":")
    }
}
