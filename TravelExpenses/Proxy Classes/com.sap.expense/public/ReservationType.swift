// # Proxy Compiler 18.3.1-fe2cc6-20180517

import Foundation
import SAPOData

open class ReservationType: EntityValue {
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }

    public static var reservationtypeid: Property = TravelexpenseMetadata.EntityTypes.reservationType.property(withName: "RESERVATIONTYPEID")

    public static var description: Property = TravelexpenseMetadata.EntityTypes.reservationType.property(withName: "DESCRIPTION")

    public init(withDefaults: Bool = true) {
        super.init(withDefaults: withDefaults, type: TravelexpenseMetadata.EntityTypes.reservationType)
    }

    open class func array(from: EntityValueList) -> Array<ReservationType> {
        return ArrayConverter.convert(from.toArray(), Array<ReservationType>())
    }

    open func copy() -> ReservationType {
        return CastRequired<ReservationType>.from(self.copyEntity())
    }

    open var description: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ReservationType.description))
        }
        set(value) {
            self.setOptionalValue(for: ReservationType.description, to: StringValue.of(optional: value))
        }
    }

    open override var isProxy: Bool {
        return true
    }

    open class func key(reservationtypeid: String?) -> EntityKey {
        return EntityKey().with(name: "RESERVATIONTYPEID", value: StringValue.of(optional: reservationtypeid))
    }

    open var old: ReservationType {
        return CastRequired<ReservationType>.from(self.oldEntity)
    }

    open var reservationtypeid: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ReservationType.reservationtypeid))
        }
        set(value) {
            self.setOptionalValue(for: ReservationType.reservationtypeid, to: StringValue.of(optional: value))
        }
    }
}
