// # Proxy Compiler 18.3.1-fe2cc6-20180517

import Foundation
import SAPOData

open class ExpenseType: EntityValue {
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }

    public static var expensetypeid: Property = TravelexpenseMetadata.EntityTypes.expenseType.property(withName: "EXPENSETYPEID")

    public static var description: Property = TravelexpenseMetadata.EntityTypes.expenseType.property(withName: "DESCRIPTION")

    public init(withDefaults: Bool = true) {
        super.init(withDefaults: withDefaults, type: TravelexpenseMetadata.EntityTypes.expenseType)
    }

    open class func array(from: EntityValueList) -> Array<ExpenseType> {
        return ArrayConverter.convert(from.toArray(), Array<ExpenseType>())
    }

    open func copy() -> ExpenseType {
        return CastRequired<ExpenseType>.from(self.copyEntity())
    }

    open var description: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ExpenseType.description))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseType.description, to: StringValue.of(optional: value))
        }
    }

    open var expensetypeid: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ExpenseType.expensetypeid))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseType.expensetypeid, to: StringValue.of(optional: value))
        }
    }

    open override var isProxy: Bool {
        return true
    }

    open class func key(expensetypeid: String?) -> EntityKey {
        return EntityKey().with(name: "EXPENSETYPEID", value: StringValue.of(optional: expensetypeid))
    }

    open var old: ExpenseType {
        return CastRequired<ExpenseType>.from(self.oldEntity)
    }
}
