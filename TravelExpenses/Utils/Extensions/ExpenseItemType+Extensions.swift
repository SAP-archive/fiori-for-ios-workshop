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

extension ExpenseItem {
    
    // Convenience method to get validation method for the different String type key paths of Expense Item
    func validationMessage(for keyPath: KeyPath<ExpenseItem, String?>) -> String? {
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
    func validationMessage(for keyPath: KeyPath<ExpenseItem, BigDecimal?>) -> String? {
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


extension ExpenseItem {
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

extension ExpenseItem {
    // get current currency for locale
    func localCurrency() -> String {
        let local = NSLocale.current.currencyCode ?? "USD"
        guard ["USD", "EUR", "GBP"].contains(local) else {
            return "USD"
        }
        return local
    }
    
    // get currency conversion for locale
    func localCurrencyAmount() -> Double {
        
        guard let value = amount?.doubleValue() else { return 0 }
        let localeCode = currencyid ?? "USD"
        var conversions = ["USD": [:], "GBP": [:], "EUR": [:]]
        conversions["USD"]?.updateValue(0.85, forKey: "EUR")
        conversions["USD"]?.updateValue(0.75, forKey: "GBP")
        conversions["GBP"]?.updateValue(1.33, forKey: "USD")
        conversions["GBP"]?.updateValue(1.13, forKey: "EUR")
        conversions["EUR"]?.updateValue(1.18, forKey: "USD")
        conversions["EUR"]?.updateValue(0.88, forKey: "GBP")
        
        guard let conversion = conversions[localeCode]?[localCurrency()] as? Double else {
            return value
        }
        return value * conversion
    }
}



