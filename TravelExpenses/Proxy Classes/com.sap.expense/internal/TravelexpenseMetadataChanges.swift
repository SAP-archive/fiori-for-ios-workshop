// # Proxy Compiler 18.3.1-fe2cc6-20180517

import Foundation
import SAPOData

internal class TravelexpenseMetadataChanges: ObjectBase {
    override init() {
    }

    class func merge(metadata: CSDLDocument) {
        metadata.hasGeneratedProxies = true
        TravelexpenseMetadata.document = metadata
        TravelexpenseMetadataChanges.merge1(metadata: metadata)
        try! TravelexpenseFactory.registerAll()
    }

    private class func merge1(metadata: CSDLDocument) {
        Ignore.valueOf_any(metadata)
        if !TravelexpenseMetadata.EntityTypes.currencyType.isRemoved {
            TravelexpenseMetadata.EntityTypes.currencyType = metadata.entityType(withName: "codejam.saptravelexpense.services.CurrencyType")
        }
        if !TravelexpenseMetadata.EntityTypes.expenseItemType.isRemoved {
            TravelexpenseMetadata.EntityTypes.expenseItemType = metadata.entityType(withName: "codejam.saptravelexpense.services.ExpenseItemType")
        }
        if !TravelexpenseMetadata.EntityTypes.expenseReportItemType.isRemoved {
            TravelexpenseMetadata.EntityTypes.expenseReportItemType = metadata.entityType(withName: "codejam.saptravelexpense.services.ExpenseReportItemType")
        }
        if !TravelexpenseMetadata.EntityTypes.expenseType.isRemoved {
            TravelexpenseMetadata.EntityTypes.expenseType = metadata.entityType(withName: "codejam.saptravelexpense.services.ExpenseType")
        }
        if !TravelexpenseMetadata.EntityTypes.paymentType.isRemoved {
            TravelexpenseMetadata.EntityTypes.paymentType = metadata.entityType(withName: "codejam.saptravelexpense.services.PaymentType")
        }
        if !TravelexpenseMetadata.EntityTypes.reportStatusType.isRemoved {
            TravelexpenseMetadata.EntityTypes.reportStatusType = metadata.entityType(withName: "codejam.saptravelexpense.services.ReportStatusType")
        }
        if !TravelexpenseMetadata.EntityTypes.reservationItemType.isRemoved {
            TravelexpenseMetadata.EntityTypes.reservationItemType = metadata.entityType(withName: "codejam.saptravelexpense.services.ReservationItemType")
        }
        if !TravelexpenseMetadata.EntityTypes.reservationType.isRemoved {
            TravelexpenseMetadata.EntityTypes.reservationType = metadata.entityType(withName: "codejam.saptravelexpense.services.ReservationType")
        }
        if !TravelexpenseMetadata.EntityTypes.tripItemType.isRemoved {
            TravelexpenseMetadata.EntityTypes.tripItemType = metadata.entityType(withName: "codejam.saptravelexpense.services.TripItemType")
        }
        if !TravelexpenseMetadata.EntitySets.currency.isRemoved {
            TravelexpenseMetadata.EntitySets.currency = metadata.entitySet(withName: "Currency")
        }
        if !TravelexpenseMetadata.EntitySets.expense.isRemoved {
            TravelexpenseMetadata.EntitySets.expense = metadata.entitySet(withName: "Expense")
        }
        if !TravelexpenseMetadata.EntitySets.expenseItem.isRemoved {
            TravelexpenseMetadata.EntitySets.expenseItem = metadata.entitySet(withName: "ExpenseItem")
        }
        if !TravelexpenseMetadata.EntitySets.expenseReportItem.isRemoved {
            TravelexpenseMetadata.EntitySets.expenseReportItem = metadata.entitySet(withName: "ExpenseReportItem")
        }
        if !TravelexpenseMetadata.EntitySets.payment.isRemoved {
            TravelexpenseMetadata.EntitySets.payment = metadata.entitySet(withName: "Payment")
        }
        if !TravelexpenseMetadata.EntitySets.reportStatus.isRemoved {
            TravelexpenseMetadata.EntitySets.reportStatus = metadata.entitySet(withName: "ReportStatus")
        }
        if !TravelexpenseMetadata.EntitySets.reservation.isRemoved {
            TravelexpenseMetadata.EntitySets.reservation = metadata.entitySet(withName: "Reservation")
        }
        if !TravelexpenseMetadata.EntitySets.reservationItem.isRemoved {
            TravelexpenseMetadata.EntitySets.reservationItem = metadata.entitySet(withName: "ReservationItem")
        }
        if !TravelexpenseMetadata.EntitySets.tripItem.isRemoved {
            TravelexpenseMetadata.EntitySets.tripItem = metadata.entitySet(withName: "TripItem")
        }
        if !CurrencyType.currencyid.isRemoved {
            CurrencyType.currencyid = TravelexpenseMetadata.EntityTypes.currencyType.property(withName: "CURRENCYID")
        }
        if !CurrencyType.description.isRemoved {
            CurrencyType.description = TravelexpenseMetadata.EntityTypes.currencyType.property(withName: "DESCRIPTION")
        }
        if !ExpenseItemType.reportid.isRemoved {
            ExpenseItemType.reportid = TravelexpenseMetadata.EntityTypes.expenseItemType.property(withName: "REPORTID")
        }
        if !ExpenseItemType.itemid.isRemoved {
            ExpenseItemType.itemid = TravelexpenseMetadata.EntityTypes.expenseItemType.property(withName: "ITEMID")
        }
        if !ExpenseItemType.expensetypeid.isRemoved {
            ExpenseItemType.expensetypeid = TravelexpenseMetadata.EntityTypes.expenseItemType.property(withName: "EXPENSETYPEID")
        }
        if !ExpenseItemType.itemdate.isRemoved {
            ExpenseItemType.itemdate = TravelexpenseMetadata.EntityTypes.expenseItemType.property(withName: "ITEMDATE")
        }
        if !ExpenseItemType.amount.isRemoved {
            ExpenseItemType.amount = TravelexpenseMetadata.EntityTypes.expenseItemType.property(withName: "AMOUNT")
        }
        if !ExpenseItemType.paymenttypeid.isRemoved {
            ExpenseItemType.paymenttypeid = TravelexpenseMetadata.EntityTypes.expenseItemType.property(withName: "PAYMENTTYPEID")
        }
        if !ExpenseItemType.vendor.isRemoved {
            ExpenseItemType.vendor = TravelexpenseMetadata.EntityTypes.expenseItemType.property(withName: "VENDOR")
        }
        if !ExpenseItemType.location.isRemoved {
            ExpenseItemType.location = TravelexpenseMetadata.EntityTypes.expenseItemType.property(withName: "LOCATION")
        }
        if !ExpenseItemType.currencyid.isRemoved {
            ExpenseItemType.currencyid = TravelexpenseMetadata.EntityTypes.expenseItemType.property(withName: "CURRENCYID")
        }
        if !ExpenseItemType.notes.isRemoved {
            ExpenseItemType.notes = TravelexpenseMetadata.EntityTypes.expenseItemType.property(withName: "NOTES")
        }
        if !ExpenseItemType.paymentType.isRemoved {
            ExpenseItemType.paymentType = TravelexpenseMetadata.EntityTypes.expenseItemType.property(withName: "paymentType")
        }
        if !ExpenseItemType.expenseType.isRemoved {
            ExpenseItemType.expenseType = TravelexpenseMetadata.EntityTypes.expenseItemType.property(withName: "expenseType")
        }
        if !ExpenseItemType.currency.isRemoved {
            ExpenseItemType.currency = TravelexpenseMetadata.EntityTypes.expenseItemType.property(withName: "currency")
        }
        if !ExpenseReportItemType.reportid.isRemoved {
            ExpenseReportItemType.reportid = TravelexpenseMetadata.EntityTypes.expenseReportItemType.property(withName: "REPORTID")
        }
        if !ExpenseReportItemType.reportname.isRemoved {
            ExpenseReportItemType.reportname = TravelexpenseMetadata.EntityTypes.expenseReportItemType.property(withName: "REPORTNAME")
        }
        if !ExpenseReportItemType.reportstart.isRemoved {
            ExpenseReportItemType.reportstart = TravelexpenseMetadata.EntityTypes.expenseReportItemType.property(withName: "REPORTSTART")
        }
        if !ExpenseReportItemType.reportend.isRemoved {
            ExpenseReportItemType.reportend = TravelexpenseMetadata.EntityTypes.expenseReportItemType.property(withName: "REPORTEND")
        }
        if !ExpenseReportItemType.reportlocation.isRemoved {
            ExpenseReportItemType.reportlocation = TravelexpenseMetadata.EntityTypes.expenseReportItemType.property(withName: "REPORTLOCATION")
        }
        if !ExpenseReportItemType.reportstatusid.isRemoved {
            ExpenseReportItemType.reportstatusid = TravelexpenseMetadata.EntityTypes.expenseReportItemType.property(withName: "REPORTSTATUSID")
        }
        if !ExpenseReportItemType.expenseItems.isRemoved {
            ExpenseReportItemType.expenseItems = TravelexpenseMetadata.EntityTypes.expenseReportItemType.property(withName: "expenseItems")
        }
        if !ExpenseReportItemType.reportStatus.isRemoved {
            ExpenseReportItemType.reportStatus = TravelexpenseMetadata.EntityTypes.expenseReportItemType.property(withName: "reportStatus")
        }
        if !ExpenseType.expensetypeid.isRemoved {
            ExpenseType.expensetypeid = TravelexpenseMetadata.EntityTypes.expenseType.property(withName: "EXPENSETYPEID")
        }
        if !ExpenseType.description.isRemoved {
            ExpenseType.description = TravelexpenseMetadata.EntityTypes.expenseType.property(withName: "DESCRIPTION")
        }
        if !PaymentType.paymenttypeid.isRemoved {
            PaymentType.paymenttypeid = TravelexpenseMetadata.EntityTypes.paymentType.property(withName: "PAYMENTTYPEID")
        }
        if !PaymentType.description.isRemoved {
            PaymentType.description = TravelexpenseMetadata.EntityTypes.paymentType.property(withName: "DESCRIPTION")
        }
        if !ReportStatusType.reportstatusid.isRemoved {
            ReportStatusType.reportstatusid = TravelexpenseMetadata.EntityTypes.reportStatusType.property(withName: "REPORTSTATUSID")
        }
        if !ReportStatusType.description.isRemoved {
            ReportStatusType.description = TravelexpenseMetadata.EntityTypes.reportStatusType.property(withName: "DESCRIPTION")
        }
        if !ReservationItemType.reservationid.isRemoved {
            ReservationItemType.reservationid = TravelexpenseMetadata.EntityTypes.reservationItemType.property(withName: "RESERVATIONID")
        }
        if !ReservationItemType.reservationtitle.isRemoved {
            ReservationItemType.reservationtitle = TravelexpenseMetadata.EntityTypes.reservationItemType.property(withName: "RESERVATIONTITLE")
        }
        if !ReservationItemType.confirmation.isRemoved {
            ReservationItemType.confirmation = TravelexpenseMetadata.EntityTypes.reservationItemType.property(withName: "CONFIRMATION")
        }
        if !ReservationItemType.reservationdate.isRemoved {
            ReservationItemType.reservationdate = TravelexpenseMetadata.EntityTypes.reservationItemType.property(withName: "RESERVATIONDATE")
        }
        if !ReservationItemType.reservationtypeid.isRemoved {
            ReservationItemType.reservationtypeid = TravelexpenseMetadata.EntityTypes.reservationItemType.property(withName: "RESERVATIONTYPEID")
        }
        if !ReservationItemType.location.isRemoved {
            ReservationItemType.location = TravelexpenseMetadata.EntityTypes.reservationItemType.property(withName: "LOCATION")
        }
        if !ReservationItemType.tripid.isRemoved {
            ReservationItemType.tripid = TravelexpenseMetadata.EntityTypes.reservationItemType.property(withName: "TRIPID")
        }
        if !ReservationItemType.reservationType.isRemoved {
            ReservationItemType.reservationType = TravelexpenseMetadata.EntityTypes.reservationItemType.property(withName: "reservationType")
        }
        if !ReservationType.reservationtypeid.isRemoved {
            ReservationType.reservationtypeid = TravelexpenseMetadata.EntityTypes.reservationType.property(withName: "RESERVATIONTYPEID")
        }
        if !ReservationType.description.isRemoved {
            ReservationType.description = TravelexpenseMetadata.EntityTypes.reservationType.property(withName: "DESCRIPTION")
        }
        if !TripItemType.tripid.isRemoved {
            TripItemType.tripid = TravelexpenseMetadata.EntityTypes.tripItemType.property(withName: "TRIPID")
        }
        if !TripItemType.description.isRemoved {
            TripItemType.description = TravelexpenseMetadata.EntityTypes.tripItemType.property(withName: "DESCRIPTION")
        }
        if !TripItemType.reservations.isRemoved {
            TripItemType.reservations = TravelexpenseMetadata.EntityTypes.tripItemType.property(withName: "reservations")
        }
    }
}
