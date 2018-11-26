// # Proxy Compiler 18.9.2-6abc59-20180924

import Foundation
import SAPOData

open class Payment: EntityValue {
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }

    private static var paymenttypeid_: Property = TravelexpenseMetadata.EntityTypes.payment.property(withName: "PAYMENTTYPEID")

    private static var description_: Property = TravelexpenseMetadata.EntityTypes.payment.property(withName: "DESCRIPTION")

    public init(withDefaults: Bool = true) {
        super.init(withDefaults: withDefaults, type: TravelexpenseMetadata.EntityTypes.payment)
    }

    open class func array(from: EntityValueList) -> Array<Payment> {
        return ArrayConverter.convert(from.toArray(), Array<Payment>())
    }

    open func copy() -> Payment {
        return CastRequired<Payment>.from(self.copyEntity())
    }

    open class var description: Property {
        get {
            objc_sync_enter(Payment.self)
            defer { objc_sync_exit(Payment.self) }
            do {
                return Payment.description_
            }
        }
        set(value) {
            objc_sync_enter(Payment.self)
            defer { objc_sync_exit(Payment.self) }
            do {
                Payment.description_ = value
            }
        }
    }

    open var description: String? {
        get {
            return StringValue.optional(self.optionalValue(for: Payment.description))
        }
        set(value) {
            self.setOptionalValue(for: Payment.description, to: StringValue.of(optional: value))
        }
    }

    open override var isProxy: Bool {
        return true
    }

    open class func key(paymenttypeid: String?) -> EntityKey {
        return EntityKey().with(name: "PAYMENTTYPEID", value: StringValue.of(optional: paymenttypeid))
    }

    open var old: Payment {
        return CastRequired<Payment>.from(self.oldEntity)
    }

    open class var paymenttypeid: Property {
        get {
            objc_sync_enter(Payment.self)
            defer { objc_sync_exit(Payment.self) }
            do {
                return Payment.paymenttypeid_
            }
        }
        set(value) {
            objc_sync_enter(Payment.self)
            defer { objc_sync_exit(Payment.self) }
            do {
                Payment.paymenttypeid_ = value
            }
        }
    }

    open var paymenttypeid: String? {
        get {
            return StringValue.optional(self.optionalValue(for: Payment.paymenttypeid))
        }
        set(value) {
            self.setOptionalValue(for: Payment.paymenttypeid, to: StringValue.of(optional: value))
        }
    }
}
