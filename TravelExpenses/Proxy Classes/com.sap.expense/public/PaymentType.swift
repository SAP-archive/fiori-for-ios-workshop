// # Proxy Compiler 18.3.3-df95fb-20180723

import Foundation
import SAPOData

open class PaymentType: EntityValue {
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }

    public static var paymenttypeid: Property = TravelexpenseMetadata.EntityTypes.paymentType.property(withName: "PAYMENTTYPEID")

    public static var description: Property = TravelexpenseMetadata.EntityTypes.paymentType.property(withName: "DESCRIPTION")

    public init(withDefaults: Bool = true) {
        super.init(withDefaults: withDefaults, type: TravelexpenseMetadata.EntityTypes.paymentType)
    }

    open class func array(from: EntityValueList) -> Array<PaymentType> {
        return ArrayConverter.convert(from.toArray(), Array<PaymentType>())
    }

    open func copy() -> PaymentType {
        return CastRequired<PaymentType>.from(self.copyEntity())
    }

    open var description: String? {
        get {
            return StringValue.optional(self.optionalValue(for: PaymentType.description))
        }
        set(value) {
            self.setOptionalValue(for: PaymentType.description, to: StringValue.of(optional: value))
        }
    }

    open override var isProxy: Bool {
        return true
    }

    open class func key(paymenttypeid: String?) -> EntityKey {
        return EntityKey().with(name: "PAYMENTTYPEID", value: StringValue.of(optional: paymenttypeid))
    }

    open var old: PaymentType {
        return CastRequired<PaymentType>.from(self.oldEntity)
    }

    open var paymenttypeid: String? {
        get {
            return StringValue.optional(self.optionalValue(for: PaymentType.paymenttypeid))
        }
        set(value) {
            self.setOptionalValue(for: PaymentType.paymenttypeid, to: StringValue.of(optional: value))
        }
    }
}
