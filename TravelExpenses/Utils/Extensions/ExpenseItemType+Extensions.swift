//
//  ExpenseitemType+Extensions.swift
//  SAP-Expense
//
//  Created by Stadelman, Stan on 4/4/18.
//  Copyright © 2018 SAP SE or an SAP affiliate company.  All rights reserved.
//

import SAPFiori
import UIKit
import SAPOData

extension ExpenseItemType {
    
    // Convenience method to get validation method for the different String type key paths of Expense Item
    func validationMessage(for keyPath: KeyPath<ExpenseItemType, String?>) -> String? {
        switch keyPath {
        case \.vendor:
            return self[keyPath: keyPath] == nil ? "Vendor is required" : nil
        case \.currencyid:
            return self[keyPath: keyPath] == nil ? "Currency is required" : nil
        case \.reportid:
            return self[keyPath: keyPath] == nil ? "Please assign this expense to a Report" : nil
        case \.expensetypeid:
            return self[keyPath: keyPath] == nil ? "Expense type is required" : nil
        case \.paymenttypeid:
            return self[keyPath: keyPath] == nil ? "Payment type is required" : nil
        default:
            return nil
        }
    }
    
    // Convenience method to get validation method for the BigDecimal type key paths of Expense Item
    func validationMessage(for keyPath: KeyPath<ExpenseItemType, BigDecimal?>) -> String? {
        switch keyPath {
        case \.amount:
            guard let value = self[keyPath: keyPath] else { return "\"Amount\" value is required." }
            
            let number = value.doubleValue()
            guard number >= 0 else { return "\"Amount\" must be greater than 0." }
            
            return nil
        default:
            return nil
        }
    }
}


extension ExpenseItemType {
    func iconImages() -> [FUIGlyphImage] {
        let attachment = FUIAttributedImage(image: FUIIconLibrary.indicator.attachment.withRenderingMode(.alwaysTemplate))
        attachment.contentMode = .center
        attachment.tintColor = UIColor.preferredFioriColor(forStyle: .primary3)
        let air = FUIAttributedImage(image: #imageLiteral(resourceName: "Flight Icon "))
        air.contentMode = .scaleAspectFit
        let taxi = FUIAttributedImage(image: #imageLiteral(resourceName: "Taxi Icon "))
        taxi.contentMode = .scaleAspectFit
        let food = FUIAttributedImage(image: #imageLiteral(resourceName: "Meal"))
        food.contentMode = .scaleAspectFit

        let alertGlyph = FUIIconLibrary.indicator.mediumPriority

        let hotelGlyph = FUIAttributedImage(image: #imageLiteral(resourceName: "Hotel"))
        hotelGlyph.contentMode = .scaleAspectFit

        var icons: [FUIGlyphImage] = []

        if self.expensetypeid == "001" {
            icons.append(air)
        }
        if self.expensetypeid == "002" {
            icons.append(hotelGlyph)
        }
        if self.expensetypeid == "003" {
            // TODO: add misc icon
        }
        if self.expensetypeid == "004" {
            icons.append(taxi)
        }
        if self.expensetypeid == "006" {
            icons.append(food)
        }
        if self.expensetypeid == "008" {
            icons.append(food)
        }

        if vendor == nil {
            icons.append(alertGlyph)
        }
        return icons
    }
}




