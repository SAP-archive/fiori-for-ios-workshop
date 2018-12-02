// # Proxy Compiler 18.9.2-6abc59-20180924

import Foundation
import SAPOData

internal class TravelexpenseStaticResolver {
    static func resolve() {
        TravelexpenseStaticResolver.resolve1()
    }

    private static func resolve1() {
        Ignore.valueOf_any(TravelexpenseMetadata.EntityTypes.currency)
        Ignore.valueOf_any(TravelexpenseMetadata.EntityTypes.expense)
        Ignore.valueOf_any(TravelexpenseMetadata.EntityTypes.expenseItem)
        Ignore.valueOf_any(TravelexpenseMetadata.EntityTypes.expenseItemAttachment)
        Ignore.valueOf_any(TravelexpenseMetadata.EntityTypes.expenseReportItem)
        Ignore.valueOf_any(TravelexpenseMetadata.EntityTypes.payment)
        Ignore.valueOf_any(TravelexpenseMetadata.EntityTypes.reportStatus)
        Ignore.valueOf_any(TravelexpenseMetadata.EntityTypes.reservation)
        Ignore.valueOf_any(TravelexpenseMetadata.EntityTypes.reservationItem)
        Ignore.valueOf_any(TravelexpenseMetadata.EntityTypes.tripItem)
        Ignore.valueOf_any(TravelexpenseMetadata.EntitySets.currencies)
        Ignore.valueOf_any(TravelexpenseMetadata.EntitySets.expenseItemAttachments)
        Ignore.valueOf_any(TravelexpenseMetadata.EntitySets.expenseItems)
        Ignore.valueOf_any(TravelexpenseMetadata.EntitySets.expenseReports)
        Ignore.valueOf_any(TravelexpenseMetadata.EntitySets.expenses)
        Ignore.valueOf_any(TravelexpenseMetadata.EntitySets.payments)
        Ignore.valueOf_any(TravelexpenseMetadata.EntitySets.reportStati)
        Ignore.valueOf_any(TravelexpenseMetadata.EntitySets.reservationItems)
        Ignore.valueOf_any(TravelexpenseMetadata.EntitySets.reservations)
        Ignore.valueOf_any(TravelexpenseMetadata.EntitySets.tripItems)
        Ignore.valueOf_any(Currency.currencyid)
        Ignore.valueOf_any(Currency.description)
        Ignore.valueOf_any(Expense.expensetypeid)
        Ignore.valueOf_any(Expense.description)
        Ignore.valueOf_any(ExpenseItem.reportid)
        Ignore.valueOf_any(ExpenseItem.itemid)
        Ignore.valueOf_any(ExpenseItem.expensetypeid)
        Ignore.valueOf_any(ExpenseItem.itemdate)
        Ignore.valueOf_any(ExpenseItem.amount)
        Ignore.valueOf_any(ExpenseItem.vendor)
        Ignore.valueOf_any(ExpenseItem.location)
        Ignore.valueOf_any(ExpenseItem.currencyid)
        Ignore.valueOf_any(ExpenseItem.notes)
        Ignore.valueOf_any(ExpenseItem.paymenttypeid)
        Ignore.valueOf_any(ExpenseItem.expenseReport)
        Ignore.valueOf_any(ExpenseItem.paymentType)
        Ignore.valueOf_any(ExpenseItem.expenseType)
        Ignore.valueOf_any(ExpenseItem.currency)
        Ignore.valueOf_any(ExpenseItem.attachments)
        Ignore.valueOf_any(ExpenseItemAttachment.attachmentid)
        Ignore.valueOf_any(ExpenseItemAttachment.name)
        Ignore.valueOf_any(ExpenseItemAttachment.reportid)
        Ignore.valueOf_any(ExpenseItemAttachment.itemid)
        Ignore.valueOf_any(ExpenseItemAttachment.expenseItem)
        Ignore.valueOf_any(ExpenseReportItem.reportid)
        Ignore.valueOf_any(ExpenseReportItem.reportname)
        Ignore.valueOf_any(ExpenseReportItem.reportstart)
        Ignore.valueOf_any(ExpenseReportItem.reportend)
        Ignore.valueOf_any(ExpenseReportItem.reportlocation)
        Ignore.valueOf_any(ExpenseReportItem.reportstatusid)
        Ignore.valueOf_any(ExpenseReportItem.expenseItems)
        Ignore.valueOf_any(ExpenseReportItem.reportStatus)
        Ignore.valueOf_any(Payment.paymenttypeid)
        Ignore.valueOf_any(Payment.description)
        Ignore.valueOf_any(ReportStatus.reportstatusid)
        Ignore.valueOf_any(ReportStatus.description)
        Ignore.valueOf_any(Reservation.reservationtypeid)
        Ignore.valueOf_any(Reservation.description)
        Ignore.valueOf_any(ReservationItem.reservationid)
        Ignore.valueOf_any(ReservationItem.reservationtitle)
        Ignore.valueOf_any(ReservationItem.confirmation)
        Ignore.valueOf_any(ReservationItem.reservationdate)
        Ignore.valueOf_any(ReservationItem.reservationtypeid)
        Ignore.valueOf_any(ReservationItem.location)
        Ignore.valueOf_any(ReservationItem.tripid)
        Ignore.valueOf_any(ReservationItem.reservationType)
        Ignore.valueOf_any(ReservationItem.tripItem)
        Ignore.valueOf_any(TripItem.tripid)
        Ignore.valueOf_any(TripItem.description)
        Ignore.valueOf_any(TripItem.reservations)
    }
}
