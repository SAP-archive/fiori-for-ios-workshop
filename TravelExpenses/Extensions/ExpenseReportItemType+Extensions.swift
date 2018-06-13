//
//  ExpensereportType+Extensions.swift
//  SAP-Expense
//
//  Created by Stadelman, Stan on 4/4/18.
//  Copyright © 2018 SAP. All rights reserved.
//

import UIKit

extension ExpenseReportItemType {
    func rangeString() -> String {
        guard let reportStart = reportstart, let reportEnd = reportend else {
            return ""
        }
        return "\(DateFormatter(.medium).string(from: reportStart.utc())) - \(DateFormatter(.medium).string(from: reportEnd.utc()))"
    }
}

