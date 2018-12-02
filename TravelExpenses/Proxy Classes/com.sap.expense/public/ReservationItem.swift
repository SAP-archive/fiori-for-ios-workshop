// # Proxy Compiler 18.9.2-6abc59-20180924

import Foundation
import SAPOData

open class ReservationItem: EntityValue {
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }

    private static var reservationid_: Property = TravelexpenseMetadata.EntityTypes.reservationItem.property(withName: "RESERVATIONID")

    private static var reservationtitle_: Property = TravelexpenseMetadata.EntityTypes.reservationItem.property(withName: "RESERVATIONTITLE")

    private static var confirmation_: Property = TravelexpenseMetadata.EntityTypes.reservationItem.property(withName: "CONFIRMATION")

    private static var reservationdate_: Property = TravelexpenseMetadata.EntityTypes.reservationItem.property(withName: "RESERVATIONDATE")

    private static var reservationtypeid_: Property = TravelexpenseMetadata.EntityTypes.reservationItem.property(withName: "RESERVATIONTYPEID")

    private static var location_: Property = TravelexpenseMetadata.EntityTypes.reservationItem.property(withName: "LOCATION")

    private static var tripid_: Property = TravelexpenseMetadata.EntityTypes.reservationItem.property(withName: "TRIPID")

    private static var reservationType_: Property = TravelexpenseMetadata.EntityTypes.reservationItem.property(withName: "reservationType")

    private static var tripItem_: Property = TravelexpenseMetadata.EntityTypes.reservationItem.property(withName: "tripItem")

    public init(withDefaults: Bool = true) {
        super.init(withDefaults: withDefaults, type: TravelexpenseMetadata.EntityTypes.reservationItem)
    }

    open class func array(from: EntityValueList) -> Array<ReservationItem> {
        return ArrayConverter.convert(from.toArray(), Array<ReservationItem>())
    }

    open class var confirmation: Property {
        get {
            objc_sync_enter(ReservationItem.self)
            defer { objc_sync_exit(ReservationItem.self) }
            do {
                return ReservationItem.confirmation_
            }
        }
        set(value) {
            objc_sync_enter(ReservationItem.self)
            defer { objc_sync_exit(ReservationItem.self) }
            do {
                ReservationItem.confirmation_ = value
            }
        }
    }

    open var confirmation: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ReservationItem.confirmation))
        }
        set(value) {
            self.setOptionalValue(for: ReservationItem.confirmation, to: StringValue.of(optional: value))
        }
    }

    open func copy() -> ReservationItem {
        return CastRequired<ReservationItem>.from(self.copyEntity())
    }

    open override var isProxy: Bool {
        return true
    }

    open class func key(reservationid: String?) -> EntityKey {
        return EntityKey().with(name: "RESERVATIONID", value: StringValue.of(optional: reservationid))
    }

    open class var location: Property {
        get {
            objc_sync_enter(ReservationItem.self)
            defer { objc_sync_exit(ReservationItem.self) }
            do {
                return ReservationItem.location_
            }
        }
        set(value) {
            objc_sync_enter(ReservationItem.self)
            defer { objc_sync_exit(ReservationItem.self) }
            do {
                ReservationItem.location_ = value
            }
        }
    }

    open var location: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ReservationItem.location))
        }
        set(value) {
            self.setOptionalValue(for: ReservationItem.location, to: StringValue.of(optional: value))
        }
    }

    open var old: ReservationItem {
        return CastRequired<ReservationItem>.from(self.oldEntity)
    }

    open class var reservationType: Property {
        get {
            objc_sync_enter(ReservationItem.self)
            defer { objc_sync_exit(ReservationItem.self) }
            do {
                return ReservationItem.reservationType_
            }
        }
        set(value) {
            objc_sync_enter(ReservationItem.self)
            defer { objc_sync_exit(ReservationItem.self) }
            do {
                ReservationItem.reservationType_ = value
            }
        }
    }

    open var reservationType: Reservation? {
        get {
            return CastOptional<Reservation>.from(self.optionalValue(for: ReservationItem.reservationType))
        }
        set(value) {
            self.setOptionalValue(for: ReservationItem.reservationType, to: value)
        }
    }

    open class var reservationdate: Property {
        get {
            objc_sync_enter(ReservationItem.self)
            defer { objc_sync_exit(ReservationItem.self) }
            do {
                return ReservationItem.reservationdate_
            }
        }
        set(value) {
            objc_sync_enter(ReservationItem.self)
            defer { objc_sync_exit(ReservationItem.self) }
            do {
                ReservationItem.reservationdate_ = value
            }
        }
    }

    open var reservationdate: LocalDateTime? {
        get {
            return LocalDateTime.castOptional(self.optionalValue(for: ReservationItem.reservationdate))
        }
        set(value) {
            self.setOptionalValue(for: ReservationItem.reservationdate, to: value)
        }
    }

    open class var reservationid: Property {
        get {
            objc_sync_enter(ReservationItem.self)
            defer { objc_sync_exit(ReservationItem.self) }
            do {
                return ReservationItem.reservationid_
            }
        }
        set(value) {
            objc_sync_enter(ReservationItem.self)
            defer { objc_sync_exit(ReservationItem.self) }
            do {
                ReservationItem.reservationid_ = value
            }
        }
    }

    open var reservationid: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ReservationItem.reservationid))
        }
        set(value) {
            self.setOptionalValue(for: ReservationItem.reservationid, to: StringValue.of(optional: value))
        }
    }

    open class var reservationtitle: Property {
        get {
            objc_sync_enter(ReservationItem.self)
            defer { objc_sync_exit(ReservationItem.self) }
            do {
                return ReservationItem.reservationtitle_
            }
        }
        set(value) {
            objc_sync_enter(ReservationItem.self)
            defer { objc_sync_exit(ReservationItem.self) }
            do {
                ReservationItem.reservationtitle_ = value
            }
        }
    }

    open var reservationtitle: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ReservationItem.reservationtitle))
        }
        set(value) {
            self.setOptionalValue(for: ReservationItem.reservationtitle, to: StringValue.of(optional: value))
        }
    }

    open class var reservationtypeid: Property {
        get {
            objc_sync_enter(ReservationItem.self)
            defer { objc_sync_exit(ReservationItem.self) }
            do {
                return ReservationItem.reservationtypeid_
            }
        }
        set(value) {
            objc_sync_enter(ReservationItem.self)
            defer { objc_sync_exit(ReservationItem.self) }
            do {
                ReservationItem.reservationtypeid_ = value
            }
        }
    }

    open var reservationtypeid: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ReservationItem.reservationtypeid))
        }
        set(value) {
            self.setOptionalValue(for: ReservationItem.reservationtypeid, to: StringValue.of(optional: value))
        }
    }

    open class var tripItem: Property {
        get {
            objc_sync_enter(ReservationItem.self)
            defer { objc_sync_exit(ReservationItem.self) }
            do {
                return ReservationItem.tripItem_
            }
        }
        set(value) {
            objc_sync_enter(ReservationItem.self)
            defer { objc_sync_exit(ReservationItem.self) }
            do {
                ReservationItem.tripItem_ = value
            }
        }
    }

    open var tripItem: TripItem? {
        get {
            return CastOptional<TripItem>.from(self.optionalValue(for: ReservationItem.tripItem))
        }
        set(value) {
            self.setOptionalValue(for: ReservationItem.tripItem, to: value)
        }
    }

    open class var tripid: Property {
        get {
            objc_sync_enter(ReservationItem.self)
            defer { objc_sync_exit(ReservationItem.self) }
            do {
                return ReservationItem.tripid_
            }
        }
        set(value) {
            objc_sync_enter(ReservationItem.self)
            defer { objc_sync_exit(ReservationItem.self) }
            do {
                ReservationItem.tripid_ = value
            }
        }
    }

    open var tripid: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ReservationItem.tripid))
        }
        set(value) {
            self.setOptionalValue(for: ReservationItem.tripid, to: StringValue.of(optional: value))
        }
    }
}
