//
//  Formatters.swift
//  TravelExpenses
//
//  Created by Stadelman, Stan on 6/9/18.
//  Copyright © 2018 SAP SE or an SAP affiliate company.  All rights reserved.
//

import UIKit

extension DateFormatter {
    convenience init(_ dateStyle: DateFormatter.Style) {
        self.init()
        self.dateStyle = dateStyle
    }
}

extension NumberFormatter {
    convenience init(_ numberStyle: NumberFormatter.Style) {
        self.init()
        self.numberStyle = numberStyle
    }
}
