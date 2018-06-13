// # Proxy Compiler 18.3.1-fe2cc6-20180517

import Foundation
import SAPOData

open class ReservationItemType: EntityValue {
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }

    public static var reservationid: Property = TravelexpenseMetadata.EntityTypes.reservationItemType.property(withName: "RESERVATIONID")

    public static var reservationtitle: Property = TravelexpenseMetadata.EntityTypes.reservationItemType.property(withName: "RESERVATIONTITLE")

    public static var confirmation: Property = TravelexpenseMetadata.EntityTypes.reservationItemType.property(withName: "CONFIRMATION")

    public static var reservationdate: Property = TravelexpenseMetadata.EntityTypes.reservationItemType.property(withName: "RESERVATIONDATE")

    public static var reservationtypeid: Property = TravelexpenseMetadata.EntityTypes.reservationItemType.property(withName: "RESERVATIONTYPEID")

    public static var location: Property = TravelexpenseMetadata.EntityTypes.reservationItemType.property(withName: "LOCATION")

    public static var tripid: Property = TravelexpenseMetadata.EntityTypes.reservationItemType.property(withName: "TRIPID")

    public static var reservationType: Property = TravelexpenseMetadata.EntityTypes.reservationItemType.property(withName: "reservationType")

    public init(withDefaults: Bool = true) {
        super.init(withDefaults: withDefaults, type: TravelexpenseMetadata.EntityTypes.reservationItemType)
    }

    open class func array(from: EntityValueList) -> Array<ReservationItemType> {
        return ArrayConverter.convert(from.toArray(), Array<ReservationItemType>())
    }

    open var confirmation: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ReservationItemType.confirmation))
        }
        set(value) {
            self.setOptionalValue(for: ReservationItemType.confirmation, to: StringValue.of(optional: value))
        }
    }

    open func copy() -> ReservationItemType {
        return CastRequired<ReservationItemType>.from(self.copyEntity())
    }

    open override var isProxy: Bool {
        return true
    }

    open class func key(reservationid: String?) -> EntityKey {
        return EntityKey().with(name: "RESERVATIONID", value: StringValue.of(optional: reservationid))
    }

    open var location: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ReservationItemType.location))
        }
        set(value) {
            self.setOptionalValue(for: ReservationItemType.location, to: StringValue.of(optional: value))
        }
    }

    open var old: ReservationItemType {
        return CastRequired<ReservationItemType>.from(self.oldEntity)
    }

    open var reservationType: ReservationType? {
        get {
            return CastOptional<ReservationType>.from(self.optionalValue(for: ReservationItemType.reservationType))
        }
        set(value) {
            self.setOptionalValue(for: ReservationItemType.reservationType, to: value)
        }
    }

    open var reservationdate: LocalDateTime? {
        get {
            return LocalDateTime.castOptional(self.optionalValue(for: ReservationItemType.reservationdate))
        }
        set(value) {
            self.setOptionalValue(for: ReservationItemType.reservationdate, to: value)
        }
    }

    open var reservationid: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ReservationItemType.reservationid))
        }
        set(value) {
            self.setOptionalValue(for: ReservationItemType.reservationid, to: StringValue.of(optional: value))
        }
    }

    open var reservationtitle: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ReservationItemType.reservationtitle))
        }
        set(value) {
            self.setOptionalValue(for: ReservationItemType.reservationtitle, to: StringValue.of(optional: value))
        }
    }

    open var reservationtypeid: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ReservationItemType.reservationtypeid))
        }
        set(value) {
            self.setOptionalValue(for: ReservationItemType.reservationtypeid, to: StringValue.of(optional: value))
        }
    }

    open var tripid: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ReservationItemType.tripid))
        }
        set(value) {
            self.setOptionalValue(for: ReservationItemType.tripid, to: StringValue.of(optional: value))
        }
    }
}
