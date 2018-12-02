// # Proxy Compiler 18.9.2-6abc59-20180924

import Foundation
import SAPOData

open class ExpenseItemAttachment: EntityValue {
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }

    private static var attachmentid_: Property = TravelexpenseMetadata.EntityTypes.expenseItemAttachment.property(withName: "ATTACHMENTID")

    private static var name_: Property = TravelexpenseMetadata.EntityTypes.expenseItemAttachment.property(withName: "NAME")

    private static var reportid_: Property = TravelexpenseMetadata.EntityTypes.expenseItemAttachment.property(withName: "REPORTID")

    private static var itemid_: Property = TravelexpenseMetadata.EntityTypes.expenseItemAttachment.property(withName: "ITEMID")

    private static var expenseItem_: Property = TravelexpenseMetadata.EntityTypes.expenseItemAttachment.property(withName: "expenseItem")

    public init(withDefaults: Bool = true) {
        super.init(withDefaults: withDefaults, type: TravelexpenseMetadata.EntityTypes.expenseItemAttachment)
    }

    open class func array(from: EntityValueList) -> Array<ExpenseItemAttachment> {
        return ArrayConverter.convert(from.toArray(), Array<ExpenseItemAttachment>())
    }

    open class var attachmentid: Property {
        get {
            objc_sync_enter(ExpenseItemAttachment.self)
            defer { objc_sync_exit(ExpenseItemAttachment.self) }
            do {
                return ExpenseItemAttachment.attachmentid_
            }
        }
        set(value) {
            objc_sync_enter(ExpenseItemAttachment.self)
            defer { objc_sync_exit(ExpenseItemAttachment.self) }
            do {
                ExpenseItemAttachment.attachmentid_ = value
            }
        }
    }

    open var attachmentid: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ExpenseItemAttachment.attachmentid))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseItemAttachment.attachmentid, to: StringValue.of(optional: value))
        }
    }

    open func copy() -> ExpenseItemAttachment {
        return CastRequired<ExpenseItemAttachment>.from(self.copyEntity())
    }

    open class var expenseItem: Property {
        get {
            objc_sync_enter(ExpenseItemAttachment.self)
            defer { objc_sync_exit(ExpenseItemAttachment.self) }
            do {
                return ExpenseItemAttachment.expenseItem_
            }
        }
        set(value) {
            objc_sync_enter(ExpenseItemAttachment.self)
            defer { objc_sync_exit(ExpenseItemAttachment.self) }
            do {
                ExpenseItemAttachment.expenseItem_ = value
            }
        }
    }

    open var expenseItem: ExpenseItem? {
        get {
            return CastOptional<ExpenseItem>.from(self.optionalValue(for: ExpenseItemAttachment.expenseItem))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseItemAttachment.expenseItem, to: value)
        }
    }

    open override var isProxy: Bool {
        return true
    }

    open class var itemid: Property {
        get {
            objc_sync_enter(ExpenseItemAttachment.self)
            defer { objc_sync_exit(ExpenseItemAttachment.self) }
            do {
                return ExpenseItemAttachment.itemid_
            }
        }
        set(value) {
            objc_sync_enter(ExpenseItemAttachment.self)
            defer { objc_sync_exit(ExpenseItemAttachment.self) }
            do {
                ExpenseItemAttachment.itemid_ = value
            }
        }
    }

    open var itemid: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ExpenseItemAttachment.itemid))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseItemAttachment.itemid, to: StringValue.of(optional: value))
        }
    }

    open class func key(attachmentid: String?) -> EntityKey {
        return EntityKey().with(name: "ATTACHMENTID", value: StringValue.of(optional: attachmentid))
    }

    open class var name: Property {
        get {
            objc_sync_enter(ExpenseItemAttachment.self)
            defer { objc_sync_exit(ExpenseItemAttachment.self) }
            do {
                return ExpenseItemAttachment.name_
            }
        }
        set(value) {
            objc_sync_enter(ExpenseItemAttachment.self)
            defer { objc_sync_exit(ExpenseItemAttachment.self) }
            do {
                ExpenseItemAttachment.name_ = value
            }
        }
    }

    open var name: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ExpenseItemAttachment.name))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseItemAttachment.name, to: StringValue.of(optional: value))
        }
    }

    open var old: ExpenseItemAttachment {
        return CastRequired<ExpenseItemAttachment>.from(self.oldEntity)
    }

    open class var reportid: Property {
        get {
            objc_sync_enter(ExpenseItemAttachment.self)
            defer { objc_sync_exit(ExpenseItemAttachment.self) }
            do {
                return ExpenseItemAttachment.reportid_
            }
        }
        set(value) {
            objc_sync_enter(ExpenseItemAttachment.self)
            defer { objc_sync_exit(ExpenseItemAttachment.self) }
            do {
                ExpenseItemAttachment.reportid_ = value
            }
        }
    }

    open var reportid: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ExpenseItemAttachment.reportid))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseItemAttachment.reportid, to: StringValue.of(optional: value))
        }
    }
}
