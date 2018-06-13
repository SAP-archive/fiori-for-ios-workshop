// # Proxy Compiler 18.3.1-fe2cc6-20180517

import Foundation
import SAPOData

internal class TravelexpenseStaticResolver: ObjectBase {
    override init() {
    }

    class func resolve() {
        TravelexpenseStaticResolver.resolve1()
    }

    private class func resolve1() {
        Ignore.valueOf_any(TravelexpenseMetadata.EntityTypes.currencyType)
        Ignore.valueOf_any(TravelexpenseMetadata.EntityTypes.expenseItemType)
        Ignore.valueOf_any(TravelexpenseMetadata.EntityTypes.expenseReportItemType)
        Ignore.valueOf_any(TravelexpenseMetadata.EntityTypes.expenseType)
        Ignore.valueOf_any(TravelexpenseMetadata.EntityTypes.paymentType)
        Ignore.valueOf_any(TravelexpenseMetadata.EntityTypes.reportStatusType)
        Ignore.valueOf_any(TravelexpenseMetadata.EntityTypes.reservationItemType)
        Ignore.valueOf_any(TravelexpenseMetadata.EntityTypes.reservationType)
        Ignore.valueOf_any(TravelexpenseMetadata.EntityTypes.tripItemType)
        Ignore.valueOf_any(TravelexpenseMetadata.EntitySets.currency)
        Ignore.valueOf_any(TravelexpenseMetadata.EntitySets.expense)
        Ignore.valueOf_any(TravelexpenseMetadata.EntitySets.expenseItem)
        Ignore.valueOf_any(TravelexpenseMetadata.EntitySets.expenseReportItem)
        Ignore.valueOf_any(TravelexpenseMetadata.EntitySets.payment)
        Ignore.valueOf_any(TravelexpenseMetadata.EntitySets.reportStatus)
        Ignore.valueOf_any(TravelexpenseMetadata.EntitySets.reservation)
        Ignore.valueOf_any(TravelexpenseMetadata.EntitySets.reservationItem)
        Ignore.valueOf_any(TravelexpenseMetadata.EntitySets.tripItem)
        Ignore.valueOf_any(CurrencyType.currencyid)
        Ignore.valueOf_any(CurrencyType.description)
        Ignore.valueOf_any(ExpenseItemType.reportid)
        Ignore.valueOf_any(ExpenseItemType.itemid)
        Ignore.valueOf_any(ExpenseItemType.expensetypeid)
        Ignore.valueOf_any(ExpenseItemType.itemdate)
        Ignore.valueOf_any(ExpenseItemType.amount)
        Ignore.valueOf_any(ExpenseItemType.paymenttypeid)
        Ignore.valueOf_any(ExpenseItemType.vendor)
        Ignore.valueOf_any(ExpenseItemType.location)
        Ignore.valueOf_any(ExpenseItemType.currencyid)
        Ignore.valueOf_any(ExpenseItemType.notes)
        Ignore.valueOf_any(ExpenseItemType.paymentType)
        Ignore.valueOf_any(ExpenseItemType.expenseType)
        Ignore.valueOf_any(ExpenseItemType.currency)
        Ignore.valueOf_any(ExpenseReportItemType.reportid)
        Ignore.valueOf_any(ExpenseReportItemType.reportname)
        Ignore.valueOf_any(ExpenseReportItemType.reportstart)
        Ignore.valueOf_any(ExpenseReportItemType.reportend)
        Ignore.valueOf_any(ExpenseReportItemType.reportlocation)
        Ignore.valueOf_any(ExpenseReportItemType.reportstatusid)
        Ignore.valueOf_any(ExpenseReportItemType.expenseItems)
        Ignore.valueOf_any(ExpenseReportItemType.reportStatus)
        Ignore.valueOf_any(ExpenseType.expensetypeid)
        Ignore.valueOf_any(ExpenseType.description)
        Ignore.valueOf_any(PaymentType.paymenttypeid)
        Ignore.valueOf_any(PaymentType.description)
        Ignore.valueOf_any(ReportStatusType.reportstatusid)
        Ignore.valueOf_any(ReportStatusType.description)
        Ignore.valueOf_any(ReservationItemType.reservationid)
        Ignore.valueOf_any(ReservationItemType.reservationtitle)
        Ignore.valueOf_any(ReservationItemType.confirmation)
        Ignore.valueOf_any(ReservationItemType.reservationdate)
        Ignore.valueOf_any(ReservationItemType.reservationtypeid)
        Ignore.valueOf_any(ReservationItemType.location)
        Ignore.valueOf_any(ReservationItemType.tripid)
        Ignore.valueOf_any(ReservationItemType.reservationType)
        Ignore.valueOf_any(ReservationType.reservationtypeid)
        Ignore.valueOf_any(ReservationType.description)
        Ignore.valueOf_any(TripItemType.tripid)
        Ignore.valueOf_any(TripItemType.description)
        Ignore.valueOf_any(TripItemType.reservations)
    }
}
