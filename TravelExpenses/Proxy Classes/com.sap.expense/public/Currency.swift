// # Proxy Compiler 18.9.2-6abc59-20180924

import Foundation
import SAPOData

open class Currency: EntityValue {
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }

    private static var currencyid_: Property = TravelexpenseMetadata.EntityTypes.currency.property(withName: "CURRENCYID")

    private static var description_: Property = TravelexpenseMetadata.EntityTypes.currency.property(withName: "DESCRIPTION")

    public init(withDefaults: Bool = true) {
        super.init(withDefaults: withDefaults, type: TravelexpenseMetadata.EntityTypes.currency)
    }

    open class func array(from: EntityValueList) -> Array<Currency> {
        return ArrayConverter.convert(from.toArray(), Array<Currency>())
    }

    open func copy() -> Currency {
        return CastRequired<Currency>.from(self.copyEntity())
    }

    open class var currencyid: Property {
        get {
            objc_sync_enter(Currency.self)
            defer { objc_sync_exit(Currency.self) }
            do {
                return Currency.currencyid_
            }
        }
        set(value) {
            objc_sync_enter(Currency.self)
            defer { objc_sync_exit(Currency.self) }
            do {
                Currency.currencyid_ = value
            }
        }
    }

    open var currencyid: String? {
        get {
            return StringValue.optional(self.optionalValue(for: Currency.currencyid))
        }
        set(value) {
            self.setOptionalValue(for: Currency.currencyid, to: StringValue.of(optional: value))
        }
    }

    open class var description: Property {
        get {
            objc_sync_enter(Currency.self)
            defer { objc_sync_exit(Currency.self) }
            do {
                return Currency.description_
            }
        }
        set(value) {
            objc_sync_enter(Currency.self)
            defer { objc_sync_exit(Currency.self) }
            do {
                Currency.description_ = value
            }
        }
    }

    open var description: String? {
        get {
            return StringValue.optional(self.optionalValue(for: Currency.description))
        }
        set(value) {
            self.setOptionalValue(for: Currency.description, to: StringValue.of(optional: value))
        }
    }

    open override var isProxy: Bool {
        return true
    }

    open class func key(currencyid: String?) -> EntityKey {
        return EntityKey().with(name: "CURRENCYID", value: StringValue.of(optional: currencyid))
    }

    open var old: Currency {
        return CastRequired<Currency>.from(self.oldEntity)
    }
}
