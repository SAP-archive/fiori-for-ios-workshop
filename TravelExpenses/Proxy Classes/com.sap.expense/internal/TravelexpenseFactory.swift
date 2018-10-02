// # Proxy Compiler 18.3.3-df95fb-20180723

import Foundation
import SAPOData

internal class TravelexpenseFactory {
    static func registerAll() throws {
        TravelexpenseMetadata.EntityTypes.currencyType.registerFactory(ObjectFactory.with(create: { CurrencyType(withDefaults: false) }, createWithDecoder: { d in try CurrencyType(from: d) }))
        TravelexpenseMetadata.EntityTypes.expenseItemAttachmentType.registerFactory(ObjectFactory.with(create: { ExpenseItemAttachmentType(withDefaults: false) }, createWithDecoder: { d in try ExpenseItemAttachmentType(from: d) }))
        TravelexpenseMetadata.EntityTypes.expenseItemType.registerFactory(ObjectFactory.with(create: { ExpenseItemType(withDefaults: false) }, createWithDecoder: { d in try ExpenseItemType(from: d) }))
        TravelexpenseMetadata.EntityTypes.expenseReportItemType.registerFactory(ObjectFactory.with(create: { ExpenseReportItemType(withDefaults: false) }, createWithDecoder: { d in try ExpenseReportItemType(from: d) }))
        TravelexpenseMetadata.EntityTypes.expenseType.registerFactory(ObjectFactory.with(create: { ExpenseType(withDefaults: false) }, createWithDecoder: { d in try ExpenseType(from: d) }))
        TravelexpenseMetadata.EntityTypes.paymentType.registerFactory(ObjectFactory.with(create: { PaymentType(withDefaults: false) }, createWithDecoder: { d in try PaymentType(from: d) }))
        TravelexpenseMetadata.EntityTypes.reportStatusType.registerFactory(ObjectFactory.with(create: { ReportStatusType(withDefaults: false) }, createWithDecoder: { d in try ReportStatusType(from: d) }))
        TravelexpenseMetadata.EntityTypes.reservationItemType.registerFactory(ObjectFactory.with(create: { ReservationItemType(withDefaults: false) }, createWithDecoder: { d in try ReservationItemType(from: d) }))
        TravelexpenseMetadata.EntityTypes.reservationType.registerFactory(ObjectFactory.with(create: { ReservationType(withDefaults: false) }, createWithDecoder: { d in try ReservationType(from: d) }))
        TravelexpenseMetadata.EntityTypes.tripItemType.registerFactory(ObjectFactory.with(create: { TripItemType(withDefaults: false) }, createWithDecoder: { d in try TripItemType(from: d) }))
        TravelexpenseStaticResolver.resolve()
    }
}
