// # Proxy Compiler 18.3.3-df95fb-20180723

import Foundation
import SAPOData

open class ExpenseItemType: EntityValue {
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }

    public static var reportid: Property = TravelexpenseMetadata.EntityTypes.expenseItemType.property(withName: "REPORTID")

    public static var itemid: Property = TravelexpenseMetadata.EntityTypes.expenseItemType.property(withName: "ITEMID")

    public static var expensetypeid: Property = TravelexpenseMetadata.EntityTypes.expenseItemType.property(withName: "EXPENSETYPEID")

    public static var itemdate: Property = TravelexpenseMetadata.EntityTypes.expenseItemType.property(withName: "ITEMDATE")

    public static var amount: Property = TravelexpenseMetadata.EntityTypes.expenseItemType.property(withName: "AMOUNT")

    public static var vendor: Property = TravelexpenseMetadata.EntityTypes.expenseItemType.property(withName: "VENDOR")

    public static var location: Property = TravelexpenseMetadata.EntityTypes.expenseItemType.property(withName: "LOCATION")

    public static var currencyid: Property = TravelexpenseMetadata.EntityTypes.expenseItemType.property(withName: "CURRENCYID")

    public static var notes: Property = TravelexpenseMetadata.EntityTypes.expenseItemType.property(withName: "NOTES")

    public static var paymenttypeid: Property = TravelexpenseMetadata.EntityTypes.expenseItemType.property(withName: "PAYMENTTYPEID")

    public static var expenseReport: Property = TravelexpenseMetadata.EntityTypes.expenseItemType.property(withName: "expenseReport")

    public static var paymentType: Property = TravelexpenseMetadata.EntityTypes.expenseItemType.property(withName: "paymentType")

    public static var expenseType: Property = TravelexpenseMetadata.EntityTypes.expenseItemType.property(withName: "expenseType")

    public static var currency: Property = TravelexpenseMetadata.EntityTypes.expenseItemType.property(withName: "currency")

    public static var attachments: Property = TravelexpenseMetadata.EntityTypes.expenseItemType.property(withName: "attachments")

    public init(withDefaults: Bool = true) {
        super.init(withDefaults: withDefaults, type: TravelexpenseMetadata.EntityTypes.expenseItemType)
    }

    open var amount: BigDecimal? {
        get {
            return DecimalValue.optional(self.optionalValue(for: ExpenseItemType.amount))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseItemType.amount, to: DecimalValue.of(optional: value))
        }
    }

    open class func array(from: EntityValueList) -> Array<ExpenseItemType> {
        return ArrayConverter.convert(from.toArray(), Array<ExpenseItemType>())
    }

    open var attachments: Array<ExpenseItemAttachmentType> {
        get {
            return ArrayConverter.convert(EntityValueList.castRequired(self.requiredValue(for: ExpenseItemType.attachments)).toArray(), Array<ExpenseItemAttachmentType>())
        }
        set(value) {
            ExpenseItemType.attachments.setEntityList(in: self, to: EntityValueList.fromArray(ArrayConverter.convert(value, Array<EntityValue>())))
        }
    }

    open func copy() -> ExpenseItemType {
        return CastRequired<ExpenseItemType>.from(self.copyEntity())
    }

    open var currency: CurrencyType? {
        get {
            return CastOptional<CurrencyType>.from(self.optionalValue(for: ExpenseItemType.currency))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseItemType.currency, to: value)
        }
    }

    open var currencyid: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ExpenseItemType.currencyid))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseItemType.currencyid, to: StringValue.of(optional: value))
        }
    }

    open var expenseReport: ExpenseReportItemType? {
        get {
            return CastOptional<ExpenseReportItemType>.from(self.optionalValue(for: ExpenseItemType.expenseReport))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseItemType.expenseReport, to: value)
        }
    }

    open var expenseType: ExpenseType? {
        get {
            return CastOptional<ExpenseType>.from(self.optionalValue(for: ExpenseItemType.expenseType))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseItemType.expenseType, to: value)
        }
    }

    open var expensetypeid: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ExpenseItemType.expensetypeid))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseItemType.expensetypeid, to: StringValue.of(optional: value))
        }
    }

    open override var isProxy: Bool {
        return true
    }

    open var itemdate: LocalDateTime? {
        get {
            return LocalDateTime.castOptional(self.optionalValue(for: ExpenseItemType.itemdate))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseItemType.itemdate, to: value)
        }
    }

    open var itemid: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ExpenseItemType.itemid))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseItemType.itemid, to: StringValue.of(optional: value))
        }
    }

    open class func key(reportid: String?, itemid: String?) -> EntityKey {
        return EntityKey().with(name: "REPORTID", value: StringValue.of(optional: reportid)).with(name: "ITEMID", value: StringValue.of(optional: itemid))
    }

    open var location: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ExpenseItemType.location))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseItemType.location, to: StringValue.of(optional: value))
        }
    }

    open var notes: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ExpenseItemType.notes))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseItemType.notes, to: StringValue.of(optional: value))
        }
    }

    open var old: ExpenseItemType {
        return CastRequired<ExpenseItemType>.from(self.oldEntity)
    }

    open var paymentType: PaymentType? {
        get {
            return CastOptional<PaymentType>.from(self.optionalValue(for: ExpenseItemType.paymentType))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseItemType.paymentType, to: value)
        }
    }

    open var paymenttypeid: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ExpenseItemType.paymenttypeid))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseItemType.paymenttypeid, to: StringValue.of(optional: value))
        }
    }

    open var reportid: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ExpenseItemType.reportid))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseItemType.reportid, to: StringValue.of(optional: value))
        }
    }

    open var vendor: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ExpenseItemType.vendor))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseItemType.vendor, to: StringValue.of(optional: value))
        }
    }
}
