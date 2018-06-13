//
//  PickableEntityType.swift
//  TravelExpenses
//
//  Created by Stadelman, Stan on 6/11/18.
//  Copyright © 2018 SAP. All rights reserved.
//

import Foundation

protocol PickableEntityType {
    var pickerUUID: String { get }
}

extension CurrencyType: PickableEntityType {
    var pickerUUID: String {
        guard let id = self.currencyid else {
            preconditionFailure("CurrencyType \(self.debugDescription) does not have currencyid")
        }
        return id
    }
}

extension ExpenseReportItemType: PickableEntityType {
    var pickerUUID: String {
        guard let id = self.reportid else {
            preconditionFailure("ExpenseReportItemType \(self.debugDescription) does not have reportId")
        }
        return id
    }
}

extension ExpenseType: PickableEntityType {
    var pickerUUID: String {
        guard let id = self.expensetypeid else {
            preconditionFailure("ExpenseItemType \(self.debugDescription) does not have expensetypeid")
        }
        return id
    }
}
extension PaymentType: PickableEntityType {
    var pickerUUID: String {
        guard let id = self.paymenttypeid else {
            preconditionFailure("PaymentType \(self.debugDescription) does not have paymenttypeid")
        }
        return id
    }
}
