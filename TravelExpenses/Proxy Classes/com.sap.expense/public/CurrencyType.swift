// # Proxy Compiler 18.3.3-df95fb-20180723

import Foundation
import SAPOData

open class CurrencyType: EntityValue {
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }

    public static var currencyid: Property = TravelexpenseMetadata.EntityTypes.currencyType.property(withName: "CURRENCYID")

    public static var description: Property = TravelexpenseMetadata.EntityTypes.currencyType.property(withName: "DESCRIPTION")

    public init(withDefaults: Bool = true) {
        super.init(withDefaults: withDefaults, type: TravelexpenseMetadata.EntityTypes.currencyType)
    }

    open class func array(from: EntityValueList) -> Array<CurrencyType> {
        return ArrayConverter.convert(from.toArray(), Array<CurrencyType>())
    }

    open func copy() -> CurrencyType {
        return CastRequired<CurrencyType>.from(self.copyEntity())
    }

    open var currencyid: String? {
        get {
            return StringValue.optional(self.optionalValue(for: CurrencyType.currencyid))
        }
        set(value) {
            self.setOptionalValue(for: CurrencyType.currencyid, to: StringValue.of(optional: value))
        }
    }

    open var description: String? {
        get {
            return StringValue.optional(self.optionalValue(for: CurrencyType.description))
        }
        set(value) {
            self.setOptionalValue(for: CurrencyType.description, to: StringValue.of(optional: value))
        }
    }

    open override var isProxy: Bool {
        return true
    }

    open class func key(currencyid: String?) -> EntityKey {
        return EntityKey().with(name: "CURRENCYID", value: StringValue.of(optional: currencyid))
    }

    open var old: CurrencyType {
        return CastRequired<CurrencyType>.from(self.oldEntity)
    }
}
