// # Proxy Compiler 18.3.1-fe2cc6-20180517

import Foundation
import SAPOData

open class TripItemType: EntityValue {
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }

    public static var tripid: Property = TravelexpenseMetadata.EntityTypes.tripItemType.property(withName: "TRIPID")

    public static var description: Property = TravelexpenseMetadata.EntityTypes.tripItemType.property(withName: "DESCRIPTION")

    public static var reservations: Property = TravelexpenseMetadata.EntityTypes.tripItemType.property(withName: "reservations")

    public init(withDefaults: Bool = true) {
        super.init(withDefaults: withDefaults, type: TravelexpenseMetadata.EntityTypes.tripItemType)
    }

    open class func array(from: EntityValueList) -> Array<TripItemType> {
        return ArrayConverter.convert(from.toArray(), Array<TripItemType>())
    }

    open func copy() -> TripItemType {
        return CastRequired<TripItemType>.from(self.copyEntity())
    }

    open var description: String? {
        get {
            return StringValue.optional(self.optionalValue(for: TripItemType.description))
        }
        set(value) {
            self.setOptionalValue(for: TripItemType.description, to: StringValue.of(optional: value))
        }
    }

    open override var isProxy: Bool {
        return true
    }

    open class func key(tripid: String?) -> EntityKey {
        return EntityKey().with(name: "TRIPID", value: StringValue.of(optional: tripid))
    }

    open var old: TripItemType {
        return CastRequired<TripItemType>.from(self.oldEntity)
    }

    open var reservations: Array<ReservationItemType> {
        get {
            return ArrayConverter.convert(EntityValueList.castRequired(self.requiredValue(for: TripItemType.reservations)).toArray(), Array<ReservationItemType>())
        }
        set(value) {
            TripItemType.reservations.setEntityList(in: self, to: EntityValueList.fromArray(ArrayConverter.convert(value, Array<EntityValue>())))
        }
    }

    open var tripid: String? {
        get {
            return StringValue.optional(self.optionalValue(for: TripItemType.tripid))
        }
        set(value) {
            self.setOptionalValue(for: TripItemType.tripid, to: StringValue.of(optional: value))
        }
    }
}
