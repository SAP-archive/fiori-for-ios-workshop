//
//  ExpensereportType+Extensions.swift
//  SAP-Expense
//
//  Created by Stadelman, Stan on 4/4/18.
//  Copyright © 2018 SAP SE or an SAP affiliate company.  All rights reserved.
//

import UIKit

extension ExpenseReportItem {
    
    // Convenience method to format start & finish date for Expense Report
    func rangeString() -> String {
        guard let reportStart = reportstart, let reportEnd = reportend else {
            return ""
        }
        return "\(DateFormatter(.medium).string(from: reportStart.utc())) - \(DateFormatter(.medium).string(from: reportEnd.utc()))"
    }
    
    // Convenience method to get validation method for the different String type key paths of Report
    func validationMessage(for keyPath: KeyPath<ExpenseReportItem, String?>) -> String? {
        switch keyPath {
        case \.reportname:
            return self[keyPath: keyPath] == nil ? "Please provide a name for your Report" : nil
        case \.reportstatusid:
            return self[keyPath: keyPath] == nil ? "The Report must have a valid status" : nil
        case \.reportlocation:
            return self[keyPath: keyPath] == nil ? "Please specify a location for this Report" : nil
        default:
            return nil
        }
    }
}

