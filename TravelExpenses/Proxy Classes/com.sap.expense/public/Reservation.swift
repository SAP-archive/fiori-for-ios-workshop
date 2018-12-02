// # Proxy Compiler 18.9.2-6abc59-20180924

import Foundation
import SAPOData

open class Reservation: EntityValue {
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }

    private static var reservationtypeid_: Property = TravelexpenseMetadata.EntityTypes.reservation.property(withName: "RESERVATIONTYPEID")

    private static var description_: Property = TravelexpenseMetadata.EntityTypes.reservation.property(withName: "DESCRIPTION")

    public init(withDefaults: Bool = true) {
        super.init(withDefaults: withDefaults, type: TravelexpenseMetadata.EntityTypes.reservation)
    }

    open class func array(from: EntityValueList) -> Array<Reservation> {
        return ArrayConverter.convert(from.toArray(), Array<Reservation>())
    }

    open func copy() -> Reservation {
        return CastRequired<Reservation>.from(self.copyEntity())
    }

    open class var description: Property {
        get {
            objc_sync_enter(Reservation.self)
            defer { objc_sync_exit(Reservation.self) }
            do {
                return Reservation.description_
            }
        }
        set(value) {
            objc_sync_enter(Reservation.self)
            defer { objc_sync_exit(Reservation.self) }
            do {
                Reservation.description_ = value
            }
        }
    }

    open var description: String? {
        get {
            return StringValue.optional(self.optionalValue(for: Reservation.description))
        }
        set(value) {
            self.setOptionalValue(for: Reservation.description, to: StringValue.of(optional: value))
        }
    }

    open override var isProxy: Bool {
        return true
    }

    open class func key(reservationtypeid: String?) -> EntityKey {
        return EntityKey().with(name: "RESERVATIONTYPEID", value: StringValue.of(optional: reservationtypeid))
    }

    open var old: Reservation {
        return CastRequired<Reservation>.from(self.oldEntity)
    }

    open class var reservationtypeid: Property {
        get {
            objc_sync_enter(Reservation.self)
            defer { objc_sync_exit(Reservation.self) }
            do {
                return Reservation.reservationtypeid_
            }
        }
        set(value) {
            objc_sync_enter(Reservation.self)
            defer { objc_sync_exit(Reservation.self) }
            do {
                Reservation.reservationtypeid_ = value
            }
        }
    }

    open var reservationtypeid: String? {
        get {
            return StringValue.optional(self.optionalValue(for: Reservation.reservationtypeid))
        }
        set(value) {
            self.setOptionalValue(for: Reservation.reservationtypeid, to: StringValue.of(optional: value))
        }
    }
}
