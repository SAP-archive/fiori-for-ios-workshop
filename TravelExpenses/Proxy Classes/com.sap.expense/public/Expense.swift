// # Proxy Compiler 18.9.2-6abc59-20180924

import Foundation
import SAPOData

open class Expense: EntityValue {
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }

    private static var expensetypeid_: Property = TravelexpenseMetadata.EntityTypes.expense.property(withName: "EXPENSETYPEID")

    private static var description_: Property = TravelexpenseMetadata.EntityTypes.expense.property(withName: "DESCRIPTION")

    public init(withDefaults: Bool = true) {
        super.init(withDefaults: withDefaults, type: TravelexpenseMetadata.EntityTypes.expense)
    }

    open class func array(from: EntityValueList) -> Array<Expense> {
        return ArrayConverter.convert(from.toArray(), Array<Expense>())
    }

    open func copy() -> Expense {
        return CastRequired<Expense>.from(self.copyEntity())
    }

    open class var description: Property {
        get {
            objc_sync_enter(Expense.self)
            defer { objc_sync_exit(Expense.self) }
            do {
                return Expense.description_
            }
        }
        set(value) {
            objc_sync_enter(Expense.self)
            defer { objc_sync_exit(Expense.self) }
            do {
                Expense.description_ = value
            }
        }
    }

    open var description: String? {
        get {
            return StringValue.optional(self.optionalValue(for: Expense.description))
        }
        set(value) {
            self.setOptionalValue(for: Expense.description, to: StringValue.of(optional: value))
        }
    }

    open class var expensetypeid: Property {
        get {
            objc_sync_enter(Expense.self)
            defer { objc_sync_exit(Expense.self) }
            do {
                return Expense.expensetypeid_
            }
        }
        set(value) {
            objc_sync_enter(Expense.self)
            defer { objc_sync_exit(Expense.self) }
            do {
                Expense.expensetypeid_ = value
            }
        }
    }

    open var expensetypeid: String? {
        get {
            return StringValue.optional(self.optionalValue(for: Expense.expensetypeid))
        }
        set(value) {
            self.setOptionalValue(for: Expense.expensetypeid, to: StringValue.of(optional: value))
        }
    }

    open override var isProxy: Bool {
        return true
    }

    open class func key(expensetypeid: String?) -> EntityKey {
        return EntityKey().with(name: "EXPENSETYPEID", value: StringValue.of(optional: expensetypeid))
    }

    open var old: Expense {
        return CastRequired<Expense>.from(self.oldEntity)
    }
}
