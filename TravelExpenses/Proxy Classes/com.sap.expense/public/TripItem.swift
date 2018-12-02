// # Proxy Compiler 18.9.2-6abc59-20180924

import Foundation
import SAPOData

open class TripItem: EntityValue {
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }

    private static var tripid_: Property = TravelexpenseMetadata.EntityTypes.tripItem.property(withName: "TRIPID")

    private static var description_: Property = TravelexpenseMetadata.EntityTypes.tripItem.property(withName: "DESCRIPTION")

    private static var reservations_: Property = TravelexpenseMetadata.EntityTypes.tripItem.property(withName: "reservations")

    public init(withDefaults: Bool = true) {
        super.init(withDefaults: withDefaults, type: TravelexpenseMetadata.EntityTypes.tripItem)
    }

    open class func array(from: EntityValueList) -> Array<TripItem> {
        return ArrayConverter.convert(from.toArray(), Array<TripItem>())
    }

    open func copy() -> TripItem {
        return CastRequired<TripItem>.from(self.copyEntity())
    }

    open class var description: Property {
        get {
            objc_sync_enter(TripItem.self)
            defer { objc_sync_exit(TripItem.self) }
            do {
                return TripItem.description_
            }
        }
        set(value) {
            objc_sync_enter(TripItem.self)
            defer { objc_sync_exit(TripItem.self) }
            do {
                TripItem.description_ = value
            }
        }
    }

    open var description: String? {
        get {
            return StringValue.optional(self.optionalValue(for: TripItem.description))
        }
        set(value) {
            self.setOptionalValue(for: TripItem.description, to: StringValue.of(optional: value))
        }
    }

    open override var isProxy: Bool {
        return true
    }

    open class func key(tripid: String?) -> EntityKey {
        return EntityKey().with(name: "TRIPID", value: StringValue.of(optional: tripid))
    }

    open var old: TripItem {
        return CastRequired<TripItem>.from(self.oldEntity)
    }

    open class var reservations: Property {
        get {
            objc_sync_enter(TripItem.self)
            defer { objc_sync_exit(TripItem.self) }
            do {
                return TripItem.reservations_
            }
        }
        set(value) {
            objc_sync_enter(TripItem.self)
            defer { objc_sync_exit(TripItem.self) }
            do {
                TripItem.reservations_ = value
            }
        }
    }

    open var reservations: Array<ReservationItem> {
        get {
            return ArrayConverter.convert(EntityValueList.castRequired(self.requiredValue(for: TripItem.reservations)).toArray(), Array<ReservationItem>())
        }
        set(value) {
            TripItem.reservations.setEntityList(in: self, to: EntityValueList.fromArray(ArrayConverter.convert(value, Array<EntityValue>())))
        }
    }

    open class var tripid: Property {
        get {
            objc_sync_enter(TripItem.self)
            defer { objc_sync_exit(TripItem.self) }
            do {
                return TripItem.tripid_
            }
        }
        set(value) {
            objc_sync_enter(TripItem.self)
            defer { objc_sync_exit(TripItem.self) }
            do {
                TripItem.tripid_ = value
            }
        }
    }

    open var tripid: String? {
        get {
            return StringValue.optional(self.optionalValue(for: TripItem.tripid))
        }
        set(value) {
            self.setOptionalValue(for: TripItem.tripid, to: StringValue.of(optional: value))
        }
    }
}
