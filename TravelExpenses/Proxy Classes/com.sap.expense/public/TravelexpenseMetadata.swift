// # Proxy Compiler 18.3.3-df95fb-20180723

import Foundation
import SAPOData

public class TravelexpenseMetadata {
    public static var document: CSDLDocument = TravelexpenseMetadata.resolve()

    private static func resolve() -> CSDLDocument {
        try! TravelexpenseFactory.registerAll()
        TravelexpenseMetadataParser.parsed.hasGeneratedProxies = true
        return TravelexpenseMetadataParser.parsed
    }

    public class EntityTypes {
        public static var currencyType: EntityType = TravelexpenseMetadataParser.parsed.entityType(withName: "codejam.saptravelexpense.services.CurrencyType")

        public static var expenseItemAttachmentType: EntityType = TravelexpenseMetadataParser.parsed.entityType(withName: "codejam.saptravelexpense.services.ExpenseItemAttachmentType")

        public static var expenseItemType: EntityType = TravelexpenseMetadataParser.parsed.entityType(withName: "codejam.saptravelexpense.services.ExpenseItemType")

        public static var expenseReportItemType: EntityType = TravelexpenseMetadataParser.parsed.entityType(withName: "codejam.saptravelexpense.services.ExpenseReportItemType")

        public static var expenseType: EntityType = TravelexpenseMetadataParser.parsed.entityType(withName: "codejam.saptravelexpense.services.ExpenseType")

        public static var paymentType: EntityType = TravelexpenseMetadataParser.parsed.entityType(withName: "codejam.saptravelexpense.services.PaymentType")

        public static var reportStatusType: EntityType = TravelexpenseMetadataParser.parsed.entityType(withName: "codejam.saptravelexpense.services.ReportStatusType")

        public static var reservationItemType: EntityType = TravelexpenseMetadataParser.parsed.entityType(withName: "codejam.saptravelexpense.services.ReservationItemType")

        public static var reservationType: EntityType = TravelexpenseMetadataParser.parsed.entityType(withName: "codejam.saptravelexpense.services.ReservationType")

        public static var tripItemType: EntityType = TravelexpenseMetadataParser.parsed.entityType(withName: "codejam.saptravelexpense.services.TripItemType")
    }

    public class EntitySets {
        public static var currency: EntitySet = TravelexpenseMetadataParser.parsed.entitySet(withName: "Currency")

        public static var expense: EntitySet = TravelexpenseMetadataParser.parsed.entitySet(withName: "Expense")

        public static var expenseItem: EntitySet = TravelexpenseMetadataParser.parsed.entitySet(withName: "ExpenseItem")

        public static var expenseItemAttachment: EntitySet = TravelexpenseMetadataParser.parsed.entitySet(withName: "ExpenseItemAttachment")

        public static var expenseReportItem: EntitySet = TravelexpenseMetadataParser.parsed.entitySet(withName: "ExpenseReportItem")

        public static var payment: EntitySet = TravelexpenseMetadataParser.parsed.entitySet(withName: "Payment")

        public static var reportStatus: EntitySet = TravelexpenseMetadataParser.parsed.entitySet(withName: "ReportStatus")

        public static var reservation: EntitySet = TravelexpenseMetadataParser.parsed.entitySet(withName: "Reservation")

        public static var reservationItem: EntitySet = TravelexpenseMetadataParser.parsed.entitySet(withName: "ReservationItem")

        public static var tripItem: EntitySet = TravelexpenseMetadataParser.parsed.entitySet(withName: "TripItem")
    }
}
