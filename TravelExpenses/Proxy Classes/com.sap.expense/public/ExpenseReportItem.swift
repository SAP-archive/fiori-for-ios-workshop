// # Proxy Compiler 18.9.2-6abc59-20180924

import Foundation
import SAPOData

open class ExpenseReportItem: EntityValue {
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }

    private static var reportid_: Property = TravelexpenseMetadata.EntityTypes.expenseReportItem.property(withName: "REPORTID")

    private static var reportname_: Property = TravelexpenseMetadata.EntityTypes.expenseReportItem.property(withName: "REPORTNAME")

    private static var reportstart_: Property = TravelexpenseMetadata.EntityTypes.expenseReportItem.property(withName: "REPORTSTART")

    private static var reportend_: Property = TravelexpenseMetadata.EntityTypes.expenseReportItem.property(withName: "REPORTEND")

    private static var reportlocation_: Property = TravelexpenseMetadata.EntityTypes.expenseReportItem.property(withName: "REPORTLOCATION")

    private static var reportstatusid_: Property = TravelexpenseMetadata.EntityTypes.expenseReportItem.property(withName: "REPORTSTATUSID")

    private static var expenseItems_: Property = TravelexpenseMetadata.EntityTypes.expenseReportItem.property(withName: "expenseItems")

    private static var reportStatus_: Property = TravelexpenseMetadata.EntityTypes.expenseReportItem.property(withName: "reportStatus")

    public init(withDefaults: Bool = true) {
        super.init(withDefaults: withDefaults, type: TravelexpenseMetadata.EntityTypes.expenseReportItem)
    }

    open class func array(from: EntityValueList) -> Array<ExpenseReportItem> {
        return ArrayConverter.convert(from.toArray(), Array<ExpenseReportItem>())
    }

    open func copy() -> ExpenseReportItem {
        return CastRequired<ExpenseReportItem>.from(self.copyEntity())
    }

    open class var expenseItems: Property {
        get {
            objc_sync_enter(ExpenseReportItem.self)
            defer { objc_sync_exit(ExpenseReportItem.self) }
            do {
                return ExpenseReportItem.expenseItems_
            }
        }
        set(value) {
            objc_sync_enter(ExpenseReportItem.self)
            defer { objc_sync_exit(ExpenseReportItem.self) }
            do {
                ExpenseReportItem.expenseItems_ = value
            }
        }
    }

    open var expenseItems: Array<ExpenseItem> {
        get {
            return ArrayConverter.convert(EntityValueList.castRequired(self.requiredValue(for: ExpenseReportItem.expenseItems)).toArray(), Array<ExpenseItem>())
        }
        set(value) {
            ExpenseReportItem.expenseItems.setEntityList(in: self, to: EntityValueList.fromArray(ArrayConverter.convert(value, Array<EntityValue>())))
        }
    }

    open override var isProxy: Bool {
        return true
    }

    open class func key(reportid: String?) -> EntityKey {
        return EntityKey().with(name: "REPORTID", value: StringValue.of(optional: reportid))
    }

    open var old: ExpenseReportItem {
        return CastRequired<ExpenseReportItem>.from(self.oldEntity)
    }

    open class var reportStatus: Property {
        get {
            objc_sync_enter(ExpenseReportItem.self)
            defer { objc_sync_exit(ExpenseReportItem.self) }
            do {
                return ExpenseReportItem.reportStatus_
            }
        }
        set(value) {
            objc_sync_enter(ExpenseReportItem.self)
            defer { objc_sync_exit(ExpenseReportItem.self) }
            do {
                ExpenseReportItem.reportStatus_ = value
            }
        }
    }

    open var reportStatus: ReportStatus? {
        get {
            return CastOptional<ReportStatus>.from(self.optionalValue(for: ExpenseReportItem.reportStatus))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseReportItem.reportStatus, to: value)
        }
    }

    open class var reportend: Property {
        get {
            objc_sync_enter(ExpenseReportItem.self)
            defer { objc_sync_exit(ExpenseReportItem.self) }
            do {
                return ExpenseReportItem.reportend_
            }
        }
        set(value) {
            objc_sync_enter(ExpenseReportItem.self)
            defer { objc_sync_exit(ExpenseReportItem.self) }
            do {
                ExpenseReportItem.reportend_ = value
            }
        }
    }

    open var reportend: LocalDateTime? {
        get {
            return LocalDateTime.castOptional(self.optionalValue(for: ExpenseReportItem.reportend))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseReportItem.reportend, to: value)
        }
    }

    open class var reportid: Property {
        get {
            objc_sync_enter(ExpenseReportItem.self)
            defer { objc_sync_exit(ExpenseReportItem.self) }
            do {
                return ExpenseReportItem.reportid_
            }
        }
        set(value) {
            objc_sync_enter(ExpenseReportItem.self)
            defer { objc_sync_exit(ExpenseReportItem.self) }
            do {
                ExpenseReportItem.reportid_ = value
            }
        }
    }

    open var reportid: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ExpenseReportItem.reportid))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseReportItem.reportid, to: StringValue.of(optional: value))
        }
    }

    open class var reportlocation: Property {
        get {
            objc_sync_enter(ExpenseReportItem.self)
            defer { objc_sync_exit(ExpenseReportItem.self) }
            do {
                return ExpenseReportItem.reportlocation_
            }
        }
        set(value) {
            objc_sync_enter(ExpenseReportItem.self)
            defer { objc_sync_exit(ExpenseReportItem.self) }
            do {
                ExpenseReportItem.reportlocation_ = value
            }
        }
    }

    open var reportlocation: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ExpenseReportItem.reportlocation))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseReportItem.reportlocation, to: StringValue.of(optional: value))
        }
    }

    open class var reportname: Property {
        get {
            objc_sync_enter(ExpenseReportItem.self)
            defer { objc_sync_exit(ExpenseReportItem.self) }
            do {
                return ExpenseReportItem.reportname_
            }
        }
        set(value) {
            objc_sync_enter(ExpenseReportItem.self)
            defer { objc_sync_exit(ExpenseReportItem.self) }
            do {
                ExpenseReportItem.reportname_ = value
            }
        }
    }

    open var reportname: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ExpenseReportItem.reportname))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseReportItem.reportname, to: StringValue.of(optional: value))
        }
    }

    open class var reportstart: Property {
        get {
            objc_sync_enter(ExpenseReportItem.self)
            defer { objc_sync_exit(ExpenseReportItem.self) }
            do {
                return ExpenseReportItem.reportstart_
            }
        }
        set(value) {
            objc_sync_enter(ExpenseReportItem.self)
            defer { objc_sync_exit(ExpenseReportItem.self) }
            do {
                ExpenseReportItem.reportstart_ = value
            }
        }
    }

    open var reportstart: LocalDateTime? {
        get {
            return LocalDateTime.castOptional(self.optionalValue(for: ExpenseReportItem.reportstart))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseReportItem.reportstart, to: value)
        }
    }

    open class var reportstatusid: Property {
        get {
            objc_sync_enter(ExpenseReportItem.self)
            defer { objc_sync_exit(ExpenseReportItem.self) }
            do {
                return ExpenseReportItem.reportstatusid_
            }
        }
        set(value) {
            objc_sync_enter(ExpenseReportItem.self)
            defer { objc_sync_exit(ExpenseReportItem.self) }
            do {
                ExpenseReportItem.reportstatusid_ = value
            }
        }
    }

    open var reportstatusid: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ExpenseReportItem.reportstatusid))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseReportItem.reportstatusid, to: StringValue.of(optional: value))
        }
    }
}
