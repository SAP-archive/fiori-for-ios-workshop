//
// CollectionType.swift
// TravelExpenses
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 14/06/18
//

import Foundation

enum CollectionType: String {
    case payment = "Payment"
    case reservation = "Reservation"
    case expense = "Expense"
    case expenseItem = "ExpenseItem"
    case tripItem = "TripItem"
    case reservationItem = "ReservationItem"
    case expenseReportItem = "ExpenseReportItem"
    case currency = "Currency"
    case reportStatus = "ReportStatus"
    case none = ""

    static let all = [
        payment, reservation, expense, expenseItem, tripItem, reservationItem, expenseReportItem, currency, reportStatus,
    ]
}
