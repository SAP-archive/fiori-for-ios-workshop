// # Proxy Compiler 18.9.2-6abc59-20180924

import Foundation
import SAPOData

internal class TravelexpenseMetadataChanges {
    static func merge(metadata: CSDLDocument) {
        metadata.hasGeneratedProxies = true
        TravelexpenseMetadata.document = metadata
        TravelexpenseMetadataChanges.merge1(metadata: metadata)
        try! TravelexpenseFactory.registerAll()
    }

    private static func merge1(metadata: CSDLDocument) {
        Ignore.valueOf_any(metadata)
        if !TravelexpenseMetadata.EntityTypes.currency.isRemoved {
            TravelexpenseMetadata.EntityTypes.currency = metadata.entityType(withName: "codejam.saptravelexpense.services.Currency")
        }
        if !TravelexpenseMetadata.EntityTypes.expense.isRemoved {
            TravelexpenseMetadata.EntityTypes.expense = metadata.entityType(withName: "codejam.saptravelexpense.services.Expense")
        }
        if !TravelexpenseMetadata.EntityTypes.expenseItem.isRemoved {
            TravelexpenseMetadata.EntityTypes.expenseItem = metadata.entityType(withName: "codejam.saptravelexpense.services.ExpenseItem")
        }
        if !TravelexpenseMetadata.EntityTypes.expenseItemAttachment.isRemoved {
            TravelexpenseMetadata.EntityTypes.expenseItemAttachment = metadata.entityType(withName: "codejam.saptravelexpense.services.ExpenseItemAttachment")
        }
        if !TravelexpenseMetadata.EntityTypes.expenseReportItem.isRemoved {
            TravelexpenseMetadata.EntityTypes.expenseReportItem = metadata.entityType(withName: "codejam.saptravelexpense.services.ExpenseReportItem")
        }
        if !TravelexpenseMetadata.EntityTypes.payment.isRemoved {
            TravelexpenseMetadata.EntityTypes.payment = metadata.entityType(withName: "codejam.saptravelexpense.services.Payment")
        }
        if !TravelexpenseMetadata.EntityTypes.reportStatus.isRemoved {
            TravelexpenseMetadata.EntityTypes.reportStatus = metadata.entityType(withName: "codejam.saptravelexpense.services.ReportStatus")
        }
        if !TravelexpenseMetadata.EntityTypes.reservation.isRemoved {
            TravelexpenseMetadata.EntityTypes.reservation = metadata.entityType(withName: "codejam.saptravelexpense.services.Reservation")
        }
        if !TravelexpenseMetadata.EntityTypes.reservationItem.isRemoved {
            TravelexpenseMetadata.EntityTypes.reservationItem = metadata.entityType(withName: "codejam.saptravelexpense.services.ReservationItem")
        }
        if !TravelexpenseMetadata.EntityTypes.tripItem.isRemoved {
            TravelexpenseMetadata.EntityTypes.tripItem = metadata.entityType(withName: "codejam.saptravelexpense.services.TripItem")
        }
        if !TravelexpenseMetadata.EntitySets.currencies.isRemoved {
            TravelexpenseMetadata.EntitySets.currencies = metadata.entitySet(withName: "Currencies")
        }
        if !TravelexpenseMetadata.EntitySets.expenseItemAttachments.isRemoved {
            TravelexpenseMetadata.EntitySets.expenseItemAttachments = metadata.entitySet(withName: "ExpenseItemAttachments")
        }
        if !TravelexpenseMetadata.EntitySets.expenseItems.isRemoved {
            TravelexpenseMetadata.EntitySets.expenseItems = metadata.entitySet(withName: "ExpenseItems")
        }
        if !TravelexpenseMetadata.EntitySets.expenseReports.isRemoved {
            TravelexpenseMetadata.EntitySets.expenseReports = metadata.entitySet(withName: "ExpenseReports")
        }
        if !TravelexpenseMetadata.EntitySets.expenses.isRemoved {
            TravelexpenseMetadata.EntitySets.expenses = metadata.entitySet(withName: "Expenses")
        }
        if !TravelexpenseMetadata.EntitySets.payments.isRemoved {
            TravelexpenseMetadata.EntitySets.payments = metadata.entitySet(withName: "Payments")
        }
        if !TravelexpenseMetadata.EntitySets.reportStati.isRemoved {
            TravelexpenseMetadata.EntitySets.reportStati = metadata.entitySet(withName: "ReportStati")
        }
        if !TravelexpenseMetadata.EntitySets.reservationItems.isRemoved {
            TravelexpenseMetadata.EntitySets.reservationItems = metadata.entitySet(withName: "ReservationItems")
        }
        if !TravelexpenseMetadata.EntitySets.reservations.isRemoved {
            TravelexpenseMetadata.EntitySets.reservations = metadata.entitySet(withName: "Reservations")
        }
        if !TravelexpenseMetadata.EntitySets.tripItems.isRemoved {
            TravelexpenseMetadata.EntitySets.tripItems = metadata.entitySet(withName: "TripItems")
        }
        if !Currency.currencyid.isRemoved {
            Currency.currencyid = TravelexpenseMetadata.EntityTypes.currency.property(withName: "CURRENCYID")
        }
        if !Currency.description.isRemoved {
            Currency.description = TravelexpenseMetadata.EntityTypes.currency.property(withName: "DESCRIPTION")
        }
        if !Expense.expensetypeid.isRemoved {
            Expense.expensetypeid = TravelexpenseMetadata.EntityTypes.expense.property(withName: "EXPENSETYPEID")
        }
        if !Expense.description.isRemoved {
            Expense.description = TravelexpenseMetadata.EntityTypes.expense.property(withName: "DESCRIPTION")
        }
        if !ExpenseItem.reportid.isRemoved {
            ExpenseItem.reportid = TravelexpenseMetadata.EntityTypes.expenseItem.property(withName: "REPORTID")
        }
        if !ExpenseItem.itemid.isRemoved {
            ExpenseItem.itemid = TravelexpenseMetadata.EntityTypes.expenseItem.property(withName: "ITEMID")
        }
        if !ExpenseItem.expensetypeid.isRemoved {
            ExpenseItem.expensetypeid = TravelexpenseMetadata.EntityTypes.expenseItem.property(withName: "EXPENSETYPEID")
        }
        if !ExpenseItem.itemdate.isRemoved {
            ExpenseItem.itemdate = TravelexpenseMetadata.EntityTypes.expenseItem.property(withName: "ITEMDATE")
        }
        if !ExpenseItem.amount.isRemoved {
            ExpenseItem.amount = TravelexpenseMetadata.EntityTypes.expenseItem.property(withName: "AMOUNT")
        }
        if !ExpenseItem.vendor.isRemoved {
            ExpenseItem.vendor = TravelexpenseMetadata.EntityTypes.expenseItem.property(withName: "VENDOR")
        }
        if !ExpenseItem.location.isRemoved {
            ExpenseItem.location = TravelexpenseMetadata.EntityTypes.expenseItem.property(withName: "LOCATION")
        }
        if !ExpenseItem.currencyid.isRemoved {
            ExpenseItem.currencyid = TravelexpenseMetadata.EntityTypes.expenseItem.property(withName: "CURRENCYID")
        }
        if !ExpenseItem.notes.isRemoved {
            ExpenseItem.notes = TravelexpenseMetadata.EntityTypes.expenseItem.property(withName: "NOTES")
        }
        if !ExpenseItem.paymenttypeid.isRemoved {
            ExpenseItem.paymenttypeid = TravelexpenseMetadata.EntityTypes.expenseItem.property(withName: "PAYMENTTYPEID")
        }
        if !ExpenseItem.expenseReport.isRemoved {
            ExpenseItem.expenseReport = TravelexpenseMetadata.EntityTypes.expenseItem.property(withName: "expenseReport")
        }
        if !ExpenseItem.paymentType.isRemoved {
            ExpenseItem.paymentType = TravelexpenseMetadata.EntityTypes.expenseItem.property(withName: "paymentType")
        }
        if !ExpenseItem.expenseType.isRemoved {
            ExpenseItem.expenseType = TravelexpenseMetadata.EntityTypes.expenseItem.property(withName: "expenseType")
        }
        if !ExpenseItem.currency.isRemoved {
            ExpenseItem.currency = TravelexpenseMetadata.EntityTypes.expenseItem.property(withName: "currency")
        }
        if !ExpenseItem.attachments.isRemoved {
            ExpenseItem.attachments = TravelexpenseMetadata.EntityTypes.expenseItem.property(withName: "attachments")
        }
        if !ExpenseItemAttachment.attachmentid.isRemoved {
            ExpenseItemAttachment.attachmentid = TravelexpenseMetadata.EntityTypes.expenseItemAttachment.property(withName: "ATTACHMENTID")
        }
        if !ExpenseItemAttachment.name.isRemoved {
            ExpenseItemAttachment.name = TravelexpenseMetadata.EntityTypes.expenseItemAttachment.property(withName: "NAME")
        }
        if !ExpenseItemAttachment.reportid.isRemoved {
            ExpenseItemAttachment.reportid = TravelexpenseMetadata.EntityTypes.expenseItemAttachment.property(withName: "REPORTID")
        }
        if !ExpenseItemAttachment.itemid.isRemoved {
            ExpenseItemAttachment.itemid = TravelexpenseMetadata.EntityTypes.expenseItemAttachment.property(withName: "ITEMID")
        }
        if !ExpenseItemAttachment.expenseItem.isRemoved {
            ExpenseItemAttachment.expenseItem = TravelexpenseMetadata.EntityTypes.expenseItemAttachment.property(withName: "expenseItem")
        }
        if !ExpenseReportItem.reportid.isRemoved {
            ExpenseReportItem.reportid = TravelexpenseMetadata.EntityTypes.expenseReportItem.property(withName: "REPORTID")
        }
        if !ExpenseReportItem.reportname.isRemoved {
            ExpenseReportItem.reportname = TravelexpenseMetadata.EntityTypes.expenseReportItem.property(withName: "REPORTNAME")
        }
        if !ExpenseReportItem.reportstart.isRemoved {
            ExpenseReportItem.reportstart = TravelexpenseMetadata.EntityTypes.expenseReportItem.property(withName: "REPORTSTART")
        }
        if !ExpenseReportItem.reportend.isRemoved {
            ExpenseReportItem.reportend = TravelexpenseMetadata.EntityTypes.expenseReportItem.property(withName: "REPORTEND")
        }
        if !ExpenseReportItem.reportlocation.isRemoved {
            ExpenseReportItem.reportlocation = TravelexpenseMetadata.EntityTypes.expenseReportItem.property(withName: "REPORTLOCATION")
        }
        if !ExpenseReportItem.reportstatusid.isRemoved {
            ExpenseReportItem.reportstatusid = TravelexpenseMetadata.EntityTypes.expenseReportItem.property(withName: "REPORTSTATUSID")
        }
        if !ExpenseReportItem.expenseItems.isRemoved {
            ExpenseReportItem.expenseItems = TravelexpenseMetadata.EntityTypes.expenseReportItem.property(withName: "expenseItems")
        }
        if !ExpenseReportItem.reportStatus.isRemoved {
            ExpenseReportItem.reportStatus = TravelexpenseMetadata.EntityTypes.expenseReportItem.property(withName: "reportStatus")
        }
        if !Payment.paymenttypeid.isRemoved {
            Payment.paymenttypeid = TravelexpenseMetadata.EntityTypes.payment.property(withName: "PAYMENTTYPEID")
        }
        if !Payment.description.isRemoved {
            Payment.description = TravelexpenseMetadata.EntityTypes.payment.property(withName: "DESCRIPTION")
        }
        if !ReportStatus.reportstatusid.isRemoved {
            ReportStatus.reportstatusid = TravelexpenseMetadata.EntityTypes.reportStatus.property(withName: "REPORTSTATUSID")
        }
        if !ReportStatus.description.isRemoved {
            ReportStatus.description = TravelexpenseMetadata.EntityTypes.reportStatus.property(withName: "DESCRIPTION")
        }
        if !Reservation.reservationtypeid.isRemoved {
            Reservation.reservationtypeid = TravelexpenseMetadata.EntityTypes.reservation.property(withName: "RESERVATIONTYPEID")
        }
        if !Reservation.description.isRemoved {
            Reservation.description = TravelexpenseMetadata.EntityTypes.reservation.property(withName: "DESCRIPTION")
        }
        if !ReservationItem.reservationid.isRemoved {
            ReservationItem.reservationid = TravelexpenseMetadata.EntityTypes.reservationItem.property(withName: "RESERVATIONID")
        }
        if !ReservationItem.reservationtitle.isRemoved {
            ReservationItem.reservationtitle = TravelexpenseMetadata.EntityTypes.reservationItem.property(withName: "RESERVATIONTITLE")
        }
        if !ReservationItem.confirmation.isRemoved {
            ReservationItem.confirmation = TravelexpenseMetadata.EntityTypes.reservationItem.property(withName: "CONFIRMATION")
        }
        if !ReservationItem.reservationdate.isRemoved {
            ReservationItem.reservationdate = TravelexpenseMetadata.EntityTypes.reservationItem.property(withName: "RESERVATIONDATE")
        }
        if !ReservationItem.reservationtypeid.isRemoved {
            ReservationItem.reservationtypeid = TravelexpenseMetadata.EntityTypes.reservationItem.property(withName: "RESERVATIONTYPEID")
        }
        if !ReservationItem.location.isRemoved {
            ReservationItem.location = TravelexpenseMetadata.EntityTypes.reservationItem.property(withName: "LOCATION")
        }
        if !ReservationItem.tripid.isRemoved {
            ReservationItem.tripid = TravelexpenseMetadata.EntityTypes.reservationItem.property(withName: "TRIPID")
        }
        if !ReservationItem.reservationType.isRemoved {
            ReservationItem.reservationType = TravelexpenseMetadata.EntityTypes.reservationItem.property(withName: "reservationType")
        }
        if !ReservationItem.tripItem.isRemoved {
            ReservationItem.tripItem = TravelexpenseMetadata.EntityTypes.reservationItem.property(withName: "tripItem")
        }
        if !TripItem.tripid.isRemoved {
            TripItem.tripid = TravelexpenseMetadata.EntityTypes.tripItem.property(withName: "TRIPID")
        }
        if !TripItem.description.isRemoved {
            TripItem.description = TravelexpenseMetadata.EntityTypes.tripItem.property(withName: "DESCRIPTION")
        }
        if !TripItem.reservations.isRemoved {
            TripItem.reservations = TravelexpenseMetadata.EntityTypes.tripItem.property(withName: "reservations")
        }
    }
}
