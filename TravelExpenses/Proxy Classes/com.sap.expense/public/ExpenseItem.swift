// # Proxy Compiler 18.9.2-6abc59-20180924

import Foundation
import SAPOData

open class ExpenseItem: EntityValue {
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }

    private static var reportid_: Property = TravelexpenseMetadata.EntityTypes.expenseItem.property(withName: "REPORTID")

    private static var itemid_: Property = TravelexpenseMetadata.EntityTypes.expenseItem.property(withName: "ITEMID")

    private static var expensetypeid_: Property = TravelexpenseMetadata.EntityTypes.expenseItem.property(withName: "EXPENSETYPEID")

    private static var itemdate_: Property = TravelexpenseMetadata.EntityTypes.expenseItem.property(withName: "ITEMDATE")

    private static var amount_: Property = TravelexpenseMetadata.EntityTypes.expenseItem.property(withName: "AMOUNT")

    private static var vendor_: Property = TravelexpenseMetadata.EntityTypes.expenseItem.property(withName: "VENDOR")

    private static var location_: Property = TravelexpenseMetadata.EntityTypes.expenseItem.property(withName: "LOCATION")

    private static var currencyid_: Property = TravelexpenseMetadata.EntityTypes.expenseItem.property(withName: "CURRENCYID")

    private static var notes_: Property = TravelexpenseMetadata.EntityTypes.expenseItem.property(withName: "NOTES")

    private static var paymenttypeid_: Property = TravelexpenseMetadata.EntityTypes.expenseItem.property(withName: "PAYMENTTYPEID")

    private static var expenseReport_: Property = TravelexpenseMetadata.EntityTypes.expenseItem.property(withName: "expenseReport")

    private static var paymentType_: Property = TravelexpenseMetadata.EntityTypes.expenseItem.property(withName: "paymentType")

    private static var expenseType_: Property = TravelexpenseMetadata.EntityTypes.expenseItem.property(withName: "expenseType")

    private static var currency_: Property = TravelexpenseMetadata.EntityTypes.expenseItem.property(withName: "currency")

    private static var attachments_: Property = TravelexpenseMetadata.EntityTypes.expenseItem.property(withName: "attachments")

    public init(withDefaults: Bool = true) {
        super.init(withDefaults: withDefaults, type: TravelexpenseMetadata.EntityTypes.expenseItem)
    }

    open class var amount: Property {
        get {
            objc_sync_enter(ExpenseItem.self)
            defer { objc_sync_exit(ExpenseItem.self) }
            do {
                return ExpenseItem.amount_
            }
        }
        set(value) {
            objc_sync_enter(ExpenseItem.self)
            defer { objc_sync_exit(ExpenseItem.self) }
            do {
                ExpenseItem.amount_ = value
            }
        }
    }

    open var amount: BigDecimal? {
        get {
            return DecimalValue.optional(self.optionalValue(for: ExpenseItem.amount))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseItem.amount, to: DecimalValue.of(optional: value))
        }
    }

    open class func array(from: EntityValueList) -> Array<ExpenseItem> {
        return ArrayConverter.convert(from.toArray(), Array<ExpenseItem>())
    }

    open class var attachments: Property {
        get {
            objc_sync_enter(ExpenseItem.self)
            defer { objc_sync_exit(ExpenseItem.self) }
            do {
                return ExpenseItem.attachments_
            }
        }
        set(value) {
            objc_sync_enter(ExpenseItem.self)
            defer { objc_sync_exit(ExpenseItem.self) }
            do {
                ExpenseItem.attachments_ = value
            }
        }
    }

    open var attachments: Array<ExpenseItemAttachment> {
        get {
            return ArrayConverter.convert(EntityValueList.castRequired(self.requiredValue(for: ExpenseItem.attachments)).toArray(), Array<ExpenseItemAttachment>())
        }
        set(value) {
            ExpenseItem.attachments.setEntityList(in: self, to: EntityValueList.fromArray(ArrayConverter.convert(value, Array<EntityValue>())))
        }
    }

    open func copy() -> ExpenseItem {
        return CastRequired<ExpenseItem>.from(self.copyEntity())
    }

    open class var currency: Property {
        get {
            objc_sync_enter(ExpenseItem.self)
            defer { objc_sync_exit(ExpenseItem.self) }
            do {
                return ExpenseItem.currency_
            }
        }
        set(value) {
            objc_sync_enter(ExpenseItem.self)
            defer { objc_sync_exit(ExpenseItem.self) }
            do {
                ExpenseItem.currency_ = value
            }
        }
    }

    open var currency: Currency? {
        get {
            return CastOptional<Currency>.from(self.optionalValue(for: ExpenseItem.currency))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseItem.currency, to: value)
        }
    }

    open class var currencyid: Property {
        get {
            objc_sync_enter(ExpenseItem.self)
            defer { objc_sync_exit(ExpenseItem.self) }
            do {
                return ExpenseItem.currencyid_
            }
        }
        set(value) {
            objc_sync_enter(ExpenseItem.self)
            defer { objc_sync_exit(ExpenseItem.self) }
            do {
                ExpenseItem.currencyid_ = value
            }
        }
    }

    open var currencyid: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ExpenseItem.currencyid))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseItem.currencyid, to: StringValue.of(optional: value))
        }
    }

    open class var expenseReport: Property {
        get {
            objc_sync_enter(ExpenseItem.self)
            defer { objc_sync_exit(ExpenseItem.self) }
            do {
                return ExpenseItem.expenseReport_
            }
        }
        set(value) {
            objc_sync_enter(ExpenseItem.self)
            defer { objc_sync_exit(ExpenseItem.self) }
            do {
                ExpenseItem.expenseReport_ = value
            }
        }
    }

    open var expenseReport: ExpenseReportItem? {
        get {
            return CastOptional<ExpenseReportItem>.from(self.optionalValue(for: ExpenseItem.expenseReport))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseItem.expenseReport, to: value)
        }
    }

    open class var expenseType: Property {
        get {
            objc_sync_enter(ExpenseItem.self)
            defer { objc_sync_exit(ExpenseItem.self) }
            do {
                return ExpenseItem.expenseType_
            }
        }
        set(value) {
            objc_sync_enter(ExpenseItem.self)
            defer { objc_sync_exit(ExpenseItem.self) }
            do {
                ExpenseItem.expenseType_ = value
            }
        }
    }

    open var expenseType: Expense? {
        get {
            return CastOptional<Expense>.from(self.optionalValue(for: ExpenseItem.expenseType))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseItem.expenseType, to: value)
        }
    }

    open class var expensetypeid: Property {
        get {
            objc_sync_enter(ExpenseItem.self)
            defer { objc_sync_exit(ExpenseItem.self) }
            do {
                return ExpenseItem.expensetypeid_
            }
        }
        set(value) {
            objc_sync_enter(ExpenseItem.self)
            defer { objc_sync_exit(ExpenseItem.self) }
            do {
                ExpenseItem.expensetypeid_ = value
            }
        }
    }

    open var expensetypeid: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ExpenseItem.expensetypeid))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseItem.expensetypeid, to: StringValue.of(optional: value))
        }
    }

    open override var isProxy: Bool {
        return true
    }

    open class var itemdate: Property {
        get {
            objc_sync_enter(ExpenseItem.self)
            defer { objc_sync_exit(ExpenseItem.self) }
            do {
                return ExpenseItem.itemdate_
            }
        }
        set(value) {
            objc_sync_enter(ExpenseItem.self)
            defer { objc_sync_exit(ExpenseItem.self) }
            do {
                ExpenseItem.itemdate_ = value
            }
        }
    }

    open var itemdate: LocalDateTime? {
        get {
            return LocalDateTime.castOptional(self.optionalValue(for: ExpenseItem.itemdate))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseItem.itemdate, to: value)
        }
    }

    open class var itemid: Property {
        get {
            objc_sync_enter(ExpenseItem.self)
            defer { objc_sync_exit(ExpenseItem.self) }
            do {
                return ExpenseItem.itemid_
            }
        }
        set(value) {
            objc_sync_enter(ExpenseItem.self)
            defer { objc_sync_exit(ExpenseItem.self) }
            do {
                ExpenseItem.itemid_ = value
            }
        }
    }

    open var itemid: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ExpenseItem.itemid))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseItem.itemid, to: StringValue.of(optional: value))
        }
    }

    open class func key(reportid: String?, itemid: String?) -> EntityKey {
        return EntityKey().with(name: "REPORTID", value: StringValue.of(optional: reportid)).with(name: "ITEMID", value: StringValue.of(optional: itemid))
    }

    open class var location: Property {
        get {
            objc_sync_enter(ExpenseItem.self)
            defer { objc_sync_exit(ExpenseItem.self) }
            do {
                return ExpenseItem.location_
            }
        }
        set(value) {
            objc_sync_enter(ExpenseItem.self)
            defer { objc_sync_exit(ExpenseItem.self) }
            do {
                ExpenseItem.location_ = value
            }
        }
    }

    open var location: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ExpenseItem.location))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseItem.location, to: StringValue.of(optional: value))
        }
    }

    open class var notes: Property {
        get {
            objc_sync_enter(ExpenseItem.self)
            defer { objc_sync_exit(ExpenseItem.self) }
            do {
                return ExpenseItem.notes_
            }
        }
        set(value) {
            objc_sync_enter(ExpenseItem.self)
            defer { objc_sync_exit(ExpenseItem.self) }
            do {
                ExpenseItem.notes_ = value
            }
        }
    }

    open var notes: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ExpenseItem.notes))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseItem.notes, to: StringValue.of(optional: value))
        }
    }

    open var old: ExpenseItem {
        return CastRequired<ExpenseItem>.from(self.oldEntity)
    }

    open class var paymentType: Property {
        get {
            objc_sync_enter(ExpenseItem.self)
            defer { objc_sync_exit(ExpenseItem.self) }
            do {
                return ExpenseItem.paymentType_
            }
        }
        set(value) {
            objc_sync_enter(ExpenseItem.self)
            defer { objc_sync_exit(ExpenseItem.self) }
            do {
                ExpenseItem.paymentType_ = value
            }
        }
    }

    open var paymentType: Payment? {
        get {
            return CastOptional<Payment>.from(self.optionalValue(for: ExpenseItem.paymentType))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseItem.paymentType, to: value)
        }
    }

    open class var paymenttypeid: Property {
        get {
            objc_sync_enter(ExpenseItem.self)
            defer { objc_sync_exit(ExpenseItem.self) }
            do {
                return ExpenseItem.paymenttypeid_
            }
        }
        set(value) {
            objc_sync_enter(ExpenseItem.self)
            defer { objc_sync_exit(ExpenseItem.self) }
            do {
                ExpenseItem.paymenttypeid_ = value
            }
        }
    }

    open var paymenttypeid: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ExpenseItem.paymenttypeid))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseItem.paymenttypeid, to: StringValue.of(optional: value))
        }
    }

    open class var reportid: Property {
        get {
            objc_sync_enter(ExpenseItem.self)
            defer { objc_sync_exit(ExpenseItem.self) }
            do {
                return ExpenseItem.reportid_
            }
        }
        set(value) {
            objc_sync_enter(ExpenseItem.self)
            defer { objc_sync_exit(ExpenseItem.self) }
            do {
                ExpenseItem.reportid_ = value
            }
        }
    }

    open var reportid: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ExpenseItem.reportid))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseItem.reportid, to: StringValue.of(optional: value))
        }
    }

    open class var vendor: Property {
        get {
            objc_sync_enter(ExpenseItem.self)
            defer { objc_sync_exit(ExpenseItem.self) }
            do {
                return ExpenseItem.vendor_
            }
        }
        set(value) {
            objc_sync_enter(ExpenseItem.self)
            defer { objc_sync_exit(ExpenseItem.self) }
            do {
                ExpenseItem.vendor_ = value
            }
        }
    }

    open var vendor: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ExpenseItem.vendor))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseItem.vendor, to: StringValue.of(optional: value))
        }
    }
}
