// # Proxy Compiler 18.9.2-6abc59-20180924

import Foundation
import SAPOData

internal class TravelexpenseFactory {
    static func registerAll() throws {
        TravelexpenseMetadata.EntityTypes.currency.registerFactory(ObjectFactory.with(create: { Currency(withDefaults: false) }, createWithDecoder: { d in try Currency(from: d) }))
        TravelexpenseMetadata.EntityTypes.expense.registerFactory(ObjectFactory.with(create: { Expense(withDefaults: false) }, createWithDecoder: { d in try Expense(from: d) }))
        TravelexpenseMetadata.EntityTypes.expenseItem.registerFactory(ObjectFactory.with(create: { ExpenseItem(withDefaults: false) }, createWithDecoder: { d in try ExpenseItem(from: d) }))
        TravelexpenseMetadata.EntityTypes.expenseItemAttachment.registerFactory(ObjectFactory.with(create: { ExpenseItemAttachment(withDefaults: false) }, createWithDecoder: { d in try ExpenseItemAttachment(from: d) }))
        TravelexpenseMetadata.EntityTypes.expenseReportItem.registerFactory(ObjectFactory.with(create: { ExpenseReportItem(withDefaults: false) }, createWithDecoder: { d in try ExpenseReportItem(from: d) }))
        TravelexpenseMetadata.EntityTypes.payment.registerFactory(ObjectFactory.with(create: { Payment(withDefaults: false) }, createWithDecoder: { d in try Payment(from: d) }))
        TravelexpenseMetadata.EntityTypes.reportStatus.registerFactory(ObjectFactory.with(create: { ReportStatus(withDefaults: false) }, createWithDecoder: { d in try ReportStatus(from: d) }))
        TravelexpenseMetadata.EntityTypes.reservation.registerFactory(ObjectFactory.with(create: { Reservation(withDefaults: false) }, createWithDecoder: { d in try Reservation(from: d) }))
        TravelexpenseMetadata.EntityTypes.reservationItem.registerFactory(ObjectFactory.with(create: { ReservationItem(withDefaults: false) }, createWithDecoder: { d in try ReservationItem(from: d) }))
        TravelexpenseMetadata.EntityTypes.tripItem.registerFactory(ObjectFactory.with(create: { TripItem(withDefaults: false) }, createWithDecoder: { d in try TripItem(from: d) }))
        TravelexpenseStaticResolver.resolve()
    }
}
