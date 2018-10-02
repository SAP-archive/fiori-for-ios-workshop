// # Proxy Compiler 18.3.3-df95fb-20180723

import Foundation
import SAPOData

open class ExpenseItemAttachmentType: EntityValue {
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }

    public static var attachmentid: Property = TravelexpenseMetadata.EntityTypes.expenseItemAttachmentType.property(withName: "ATTACHMENTID")

    public static var name: Property = TravelexpenseMetadata.EntityTypes.expenseItemAttachmentType.property(withName: "NAME")

    public static var reportid: Property = TravelexpenseMetadata.EntityTypes.expenseItemAttachmentType.property(withName: "REPORTID")

    public static var itemid: Property = TravelexpenseMetadata.EntityTypes.expenseItemAttachmentType.property(withName: "ITEMID")

    public static var expenseItem: Property = TravelexpenseMetadata.EntityTypes.expenseItemAttachmentType.property(withName: "expenseItem")

    public init(withDefaults: Bool = true) {
        super.init(withDefaults: withDefaults, type: TravelexpenseMetadata.EntityTypes.expenseItemAttachmentType)
    }

    open class func array(from: EntityValueList) -> Array<ExpenseItemAttachmentType> {
        return ArrayConverter.convert(from.toArray(), Array<ExpenseItemAttachmentType>())
    }

    open var attachmentid: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ExpenseItemAttachmentType.attachmentid))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseItemAttachmentType.attachmentid, to: StringValue.of(optional: value))
        }
    }

    open func copy() -> ExpenseItemAttachmentType {
        return CastRequired<ExpenseItemAttachmentType>.from(self.copyEntity())
    }

    open var expenseItem: ExpenseItemType? {
        get {
            return CastOptional<ExpenseItemType>.from(self.optionalValue(for: ExpenseItemAttachmentType.expenseItem))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseItemAttachmentType.expenseItem, to: value)
        }
    }

    open override var isProxy: Bool {
        return true
    }

    open var itemid: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ExpenseItemAttachmentType.itemid))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseItemAttachmentType.itemid, to: StringValue.of(optional: value))
        }
    }

    open class func key(attachmentid: String?) -> EntityKey {
        return EntityKey().with(name: "ATTACHMENTID", value: StringValue.of(optional: attachmentid))
    }

    open var name: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ExpenseItemAttachmentType.name))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseItemAttachmentType.name, to: StringValue.of(optional: value))
        }
    }

    open var old: ExpenseItemAttachmentType {
        return CastRequired<ExpenseItemAttachmentType>.from(self.oldEntity)
    }

    open var reportid: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ExpenseItemAttachmentType.reportid))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseItemAttachmentType.reportid, to: StringValue.of(optional: value))
        }
    }
}
