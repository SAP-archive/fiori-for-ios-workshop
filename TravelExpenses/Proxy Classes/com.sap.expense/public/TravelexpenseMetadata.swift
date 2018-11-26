// # Proxy Compiler 18.9.2-6abc59-20180924

import Foundation
import SAPOData

public class TravelexpenseMetadata {
    private static var document_: CSDLDocument = TravelexpenseMetadata.resolve()

    public static var document: CSDLDocument {
        get {
            objc_sync_enter(TravelexpenseMetadata.self)
            defer { objc_sync_exit(TravelexpenseMetadata.self) }
            do {
                return TravelexpenseMetadata.document_
            }
        }
        set(value) {
            objc_sync_enter(TravelexpenseMetadata.self)
            defer { objc_sync_exit(TravelexpenseMetadata.self) }
            do {
                TravelexpenseMetadata.document_ = value
            }
        }
    }

    private static func resolve() -> CSDLDocument {
        try! TravelexpenseFactory.registerAll()
        TravelexpenseMetadataParser.parsed.hasGeneratedProxies = true
        return TravelexpenseMetadataParser.parsed
    }

    public class EntityTypes {
        private static var currency_: EntityType = TravelexpenseMetadataParser.parsed.entityType(withName: "codejam.saptravelexpense.services.Currency")

        private static var expense_: EntityType = TravelexpenseMetadataParser.parsed.entityType(withName: "codejam.saptravelexpense.services.Expense")

        private static var expenseItem_: EntityType = TravelexpenseMetadataParser.parsed.entityType(withName: "codejam.saptravelexpense.services.ExpenseItem")

        private static var expenseItemAttachment_: EntityType = TravelexpenseMetadataParser.parsed.entityType(withName: "codejam.saptravelexpense.services.ExpenseItemAttachment")

        private static var expenseReportItem_: EntityType = TravelexpenseMetadataParser.parsed.entityType(withName: "codejam.saptravelexpense.services.ExpenseReportItem")

        private static var payment_: EntityType = TravelexpenseMetadataParser.parsed.entityType(withName: "codejam.saptravelexpense.services.Payment")

        private static var reportStatus_: EntityType = TravelexpenseMetadataParser.parsed.entityType(withName: "codejam.saptravelexpense.services.ReportStatus")

        private static var reservation_: EntityType = TravelexpenseMetadataParser.parsed.entityType(withName: "codejam.saptravelexpense.services.Reservation")

        private static var reservationItem_: EntityType = TravelexpenseMetadataParser.parsed.entityType(withName: "codejam.saptravelexpense.services.ReservationItem")

        private static var tripItem_: EntityType = TravelexpenseMetadataParser.parsed.entityType(withName: "codejam.saptravelexpense.services.TripItem")

        public static var currency: EntityType {
            get {
                objc_sync_enter(TravelexpenseMetadata.EntityTypes.self)
                defer { objc_sync_exit(TravelexpenseMetadata.EntityTypes.self) }
                do {
                    return TravelexpenseMetadata.EntityTypes.currency_
                }
            }
            set(value) {
                objc_sync_enter(TravelexpenseMetadata.EntityTypes.self)
                defer { objc_sync_exit(TravelexpenseMetadata.EntityTypes.self) }
                do {
                    TravelexpenseMetadata.EntityTypes.currency_ = value
                }
            }
        }

        public static var expense: EntityType {
            get {
                objc_sync_enter(TravelexpenseMetadata.EntityTypes.self)
                defer { objc_sync_exit(TravelexpenseMetadata.EntityTypes.self) }
                do {
                    return TravelexpenseMetadata.EntityTypes.expense_
                }
            }
            set(value) {
                objc_sync_enter(TravelexpenseMetadata.EntityTypes.self)
                defer { objc_sync_exit(TravelexpenseMetadata.EntityTypes.self) }
                do {
                    TravelexpenseMetadata.EntityTypes.expense_ = value
                }
            }
        }

        public static var expenseItem: EntityType {
            get {
                objc_sync_enter(TravelexpenseMetadata.EntityTypes.self)
                defer { objc_sync_exit(TravelexpenseMetadata.EntityTypes.self) }
                do {
                    return TravelexpenseMetadata.EntityTypes.expenseItem_
                }
            }
            set(value) {
                objc_sync_enter(TravelexpenseMetadata.EntityTypes.self)
                defer { objc_sync_exit(TravelexpenseMetadata.EntityTypes.self) }
                do {
                    TravelexpenseMetadata.EntityTypes.expenseItem_ = value
                }
            }
        }

        public static var expenseItemAttachment: EntityType {
            get {
                objc_sync_enter(TravelexpenseMetadata.EntityTypes.self)
                defer { objc_sync_exit(TravelexpenseMetadata.EntityTypes.self) }
                do {
                    return TravelexpenseMetadata.EntityTypes.expenseItemAttachment_
                }
            }
            set(value) {
                objc_sync_enter(TravelexpenseMetadata.EntityTypes.self)
                defer { objc_sync_exit(TravelexpenseMetadata.EntityTypes.self) }
                do {
                    TravelexpenseMetadata.EntityTypes.expenseItemAttachment_ = value
                }
            }
        }

        public static var expenseReportItem: EntityType {
            get {
                objc_sync_enter(TravelexpenseMetadata.EntityTypes.self)
                defer { objc_sync_exit(TravelexpenseMetadata.EntityTypes.self) }
                do {
                    return TravelexpenseMetadata.EntityTypes.expenseReportItem_
                }
            }
            set(value) {
                objc_sync_enter(TravelexpenseMetadata.EntityTypes.self)
                defer { objc_sync_exit(TravelexpenseMetadata.EntityTypes.self) }
                do {
                    TravelexpenseMetadata.EntityTypes.expenseReportItem_ = value
                }
            }
        }

        public static var payment: EntityType {
            get {
                objc_sync_enter(TravelexpenseMetadata.EntityTypes.self)
                defer { objc_sync_exit(TravelexpenseMetadata.EntityTypes.self) }
                do {
                    return TravelexpenseMetadata.EntityTypes.payment_
                }
            }
            set(value) {
                objc_sync_enter(TravelexpenseMetadata.EntityTypes.self)
                defer { objc_sync_exit(TravelexpenseMetadata.EntityTypes.self) }
                do {
                    TravelexpenseMetadata.EntityTypes.payment_ = value
                }
            }
        }

        public static var reportStatus: EntityType {
            get {
                objc_sync_enter(TravelexpenseMetadata.EntityTypes.self)
                defer { objc_sync_exit(TravelexpenseMetadata.EntityTypes.self) }
                do {
                    return TravelexpenseMetadata.EntityTypes.reportStatus_
                }
            }
            set(value) {
                objc_sync_enter(TravelexpenseMetadata.EntityTypes.self)
                defer { objc_sync_exit(TravelexpenseMetadata.EntityTypes.self) }
                do {
                    TravelexpenseMetadata.EntityTypes.reportStatus_ = value
                }
            }
        }

        public static var reservation: EntityType {
            get {
                objc_sync_enter(TravelexpenseMetadata.EntityTypes.self)
                defer { objc_sync_exit(TravelexpenseMetadata.EntityTypes.self) }
                do {
                    return TravelexpenseMetadata.EntityTypes.reservation_
                }
            }
            set(value) {
                objc_sync_enter(TravelexpenseMetadata.EntityTypes.self)
                defer { objc_sync_exit(TravelexpenseMetadata.EntityTypes.self) }
                do {
                    TravelexpenseMetadata.EntityTypes.reservation_ = value
                }
            }
        }

        public static var reservationItem: EntityType {
            get {
                objc_sync_enter(TravelexpenseMetadata.EntityTypes.self)
                defer { objc_sync_exit(TravelexpenseMetadata.EntityTypes.self) }
                do {
                    return TravelexpenseMetadata.EntityTypes.reservationItem_
                }
            }
            set(value) {
                objc_sync_enter(TravelexpenseMetadata.EntityTypes.self)
                defer { objc_sync_exit(TravelexpenseMetadata.EntityTypes.self) }
                do {
                    TravelexpenseMetadata.EntityTypes.reservationItem_ = value
                }
            }
        }

        public static var tripItem: EntityType {
            get {
                objc_sync_enter(TravelexpenseMetadata.EntityTypes.self)
                defer { objc_sync_exit(TravelexpenseMetadata.EntityTypes.self) }
                do {
                    return TravelexpenseMetadata.EntityTypes.tripItem_
                }
            }
            set(value) {
                objc_sync_enter(TravelexpenseMetadata.EntityTypes.self)
                defer { objc_sync_exit(TravelexpenseMetadata.EntityTypes.self) }
                do {
                    TravelexpenseMetadata.EntityTypes.tripItem_ = value
                }
            }
        }
    }

    public class EntitySets {
        private static var currencies_: EntitySet = TravelexpenseMetadataParser.parsed.entitySet(withName: "Currencies")

        private static var expenseItemAttachments_: EntitySet = TravelexpenseMetadataParser.parsed.entitySet(withName: "ExpenseItemAttachments")

        private static var expenseItems_: EntitySet = TravelexpenseMetadataParser.parsed.entitySet(withName: "ExpenseItems")

        private static var expenseReports_: EntitySet = TravelexpenseMetadataParser.parsed.entitySet(withName: "ExpenseReports")

        private static var expenses_: EntitySet = TravelexpenseMetadataParser.parsed.entitySet(withName: "Expenses")

        private static var payments_: EntitySet = TravelexpenseMetadataParser.parsed.entitySet(withName: "Payments")

        private static var reportStati_: EntitySet = TravelexpenseMetadataParser.parsed.entitySet(withName: "ReportStati")

        private static var reservationItems_: EntitySet = TravelexpenseMetadataParser.parsed.entitySet(withName: "ReservationItems")

        private static var reservations_: EntitySet = TravelexpenseMetadataParser.parsed.entitySet(withName: "Reservations")

        private static var tripItems_: EntitySet = TravelexpenseMetadataParser.parsed.entitySet(withName: "TripItems")

        public static var currencies: EntitySet {
            get {
                objc_sync_enter(TravelexpenseMetadata.EntitySets.self)
                defer { objc_sync_exit(TravelexpenseMetadata.EntitySets.self) }
                do {
                    return TravelexpenseMetadata.EntitySets.currencies_
                }
            }
            set(value) {
                objc_sync_enter(TravelexpenseMetadata.EntitySets.self)
                defer { objc_sync_exit(TravelexpenseMetadata.EntitySets.self) }
                do {
                    TravelexpenseMetadata.EntitySets.currencies_ = value
                }
            }
        }

        public static var expenseItemAttachments: EntitySet {
            get {
                objc_sync_enter(TravelexpenseMetadata.EntitySets.self)
                defer { objc_sync_exit(TravelexpenseMetadata.EntitySets.self) }
                do {
                    return TravelexpenseMetadata.EntitySets.expenseItemAttachments_
                }
            }
            set(value) {
                objc_sync_enter(TravelexpenseMetadata.EntitySets.self)
                defer { objc_sync_exit(TravelexpenseMetadata.EntitySets.self) }
                do {
                    TravelexpenseMetadata.EntitySets.expenseItemAttachments_ = value
                }
            }
        }

        public static var expenseItems: EntitySet {
            get {
                objc_sync_enter(TravelexpenseMetadata.EntitySets.self)
                defer { objc_sync_exit(TravelexpenseMetadata.EntitySets.self) }
                do {
                    return TravelexpenseMetadata.EntitySets.expenseItems_
                }
            }
            set(value) {
                objc_sync_enter(TravelexpenseMetadata.EntitySets.self)
                defer { objc_sync_exit(TravelexpenseMetadata.EntitySets.self) }
                do {
                    TravelexpenseMetadata.EntitySets.expenseItems_ = value
                }
            }
        }

        public static var expenseReports: EntitySet {
            get {
                objc_sync_enter(TravelexpenseMetadata.EntitySets.self)
                defer { objc_sync_exit(TravelexpenseMetadata.EntitySets.self) }
                do {
                    return TravelexpenseMetadata.EntitySets.expenseReports_
                }
            }
            set(value) {
                objc_sync_enter(TravelexpenseMetadata.EntitySets.self)
                defer { objc_sync_exit(TravelexpenseMetadata.EntitySets.self) }
                do {
                    TravelexpenseMetadata.EntitySets.expenseReports_ = value
                }
            }
        }

        public static var expenses: EntitySet {
            get {
                objc_sync_enter(TravelexpenseMetadata.EntitySets.self)
                defer { objc_sync_exit(TravelexpenseMetadata.EntitySets.self) }
                do {
                    return TravelexpenseMetadata.EntitySets.expenses_
                }
            }
            set(value) {
                objc_sync_enter(TravelexpenseMetadata.EntitySets.self)
                defer { objc_sync_exit(TravelexpenseMetadata.EntitySets.self) }
                do {
                    TravelexpenseMetadata.EntitySets.expenses_ = value
                }
            }
        }

        public static var payments: EntitySet {
            get {
                objc_sync_enter(TravelexpenseMetadata.EntitySets.self)
                defer { objc_sync_exit(TravelexpenseMetadata.EntitySets.self) }
                do {
                    return TravelexpenseMetadata.EntitySets.payments_
                }
            }
            set(value) {
                objc_sync_enter(TravelexpenseMetadata.EntitySets.self)
                defer { objc_sync_exit(TravelexpenseMetadata.EntitySets.self) }
                do {
                    TravelexpenseMetadata.EntitySets.payments_ = value
                }
            }
        }

        public static var reportStati: EntitySet {
            get {
                objc_sync_enter(TravelexpenseMetadata.EntitySets.self)
                defer { objc_sync_exit(TravelexpenseMetadata.EntitySets.self) }
                do {
                    return TravelexpenseMetadata.EntitySets.reportStati_
                }
            }
            set(value) {
                objc_sync_enter(TravelexpenseMetadata.EntitySets.self)
                defer { objc_sync_exit(TravelexpenseMetadata.EntitySets.self) }
                do {
                    TravelexpenseMetadata.EntitySets.reportStati_ = value
                }
            }
        }

        public static var reservationItems: EntitySet {
            get {
                objc_sync_enter(TravelexpenseMetadata.EntitySets.self)
                defer { objc_sync_exit(TravelexpenseMetadata.EntitySets.self) }
                do {
                    return TravelexpenseMetadata.EntitySets.reservationItems_
                }
            }
            set(value) {
                objc_sync_enter(TravelexpenseMetadata.EntitySets.self)
                defer { objc_sync_exit(TravelexpenseMetadata.EntitySets.self) }
                do {
                    TravelexpenseMetadata.EntitySets.reservationItems_ = value
                }
            }
        }

        public static var reservations: EntitySet {
            get {
                objc_sync_enter(TravelexpenseMetadata.EntitySets.self)
                defer { objc_sync_exit(TravelexpenseMetadata.EntitySets.self) }
                do {
                    return TravelexpenseMetadata.EntitySets.reservations_
                }
            }
            set(value) {
                objc_sync_enter(TravelexpenseMetadata.EntitySets.self)
                defer { objc_sync_exit(TravelexpenseMetadata.EntitySets.self) }
                do {
                    TravelexpenseMetadata.EntitySets.reservations_ = value
                }
            }
        }

        public static var tripItems: EntitySet {
            get {
                objc_sync_enter(TravelexpenseMetadata.EntitySets.self)
                defer { objc_sync_exit(TravelexpenseMetadata.EntitySets.self) }
                do {
                    return TravelexpenseMetadata.EntitySets.tripItems_
                }
            }
            set(value) {
                objc_sync_enter(TravelexpenseMetadata.EntitySets.self)
                defer { objc_sync_exit(TravelexpenseMetadata.EntitySets.self) }
                do {
                    TravelexpenseMetadata.EntitySets.tripItems_ = value
                }
            }
        }
    }
}
