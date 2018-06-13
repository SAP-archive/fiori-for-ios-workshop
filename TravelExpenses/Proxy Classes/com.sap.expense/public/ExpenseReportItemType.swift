// # Proxy Compiler 18.3.1-fe2cc6-20180517

import Foundation
import SAPOData

open class ExpenseReportItemType: EntityValue {
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }

    public static var reportid: Property = TravelexpenseMetadata.EntityTypes.expenseReportItemType.property(withName: "REPORTID")

    public static var reportname: Property = TravelexpenseMetadata.EntityTypes.expenseReportItemType.property(withName: "REPORTNAME")

    public static var reportstart: Property = TravelexpenseMetadata.EntityTypes.expenseReportItemType.property(withName: "REPORTSTART")

    public static var reportend: Property = TravelexpenseMetadata.EntityTypes.expenseReportItemType.property(withName: "REPORTEND")

    public static var reportlocation: Property = TravelexpenseMetadata.EntityTypes.expenseReportItemType.property(withName: "REPORTLOCATION")

    public static var reportstatusid: Property = TravelexpenseMetadata.EntityTypes.expenseReportItemType.property(withName: "REPORTSTATUSID")

    public static var expenseItems: Property = TravelexpenseMetadata.EntityTypes.expenseReportItemType.property(withName: "expenseItems")

    public static var reportStatus: Property = TravelexpenseMetadata.EntityTypes.expenseReportItemType.property(withName: "reportStatus")

    public init(withDefaults: Bool = true) {
        super.init(withDefaults: withDefaults, type: TravelexpenseMetadata.EntityTypes.expenseReportItemType)
    }

    open class func array(from: EntityValueList) -> Array<ExpenseReportItemType> {
        return ArrayConverter.convert(from.toArray(), Array<ExpenseReportItemType>())
    }

    open func copy() -> ExpenseReportItemType {
        return CastRequired<ExpenseReportItemType>.from(self.copyEntity())
    }

    open var expenseItems: Array<ExpenseItemType> {
        get {
            return ArrayConverter.convert(EntityValueList.castRequired(self.requiredValue(for: ExpenseReportItemType.expenseItems)).toArray(), Array<ExpenseItemType>())
        }
        set(value) {
            ExpenseReportItemType.expenseItems.setEntityList(in: self, to: EntityValueList.fromArray(ArrayConverter.convert(value, Array<EntityValue>())))
        }
    }

    open override var isProxy: Bool {
        return true
    }

    open class func key(reportid: String?) -> EntityKey {
        return EntityKey().with(name: "REPORTID", value: StringValue.of(optional: reportid))
    }

    open var old: ExpenseReportItemType {
        return CastRequired<ExpenseReportItemType>.from(self.oldEntity)
    }

    open var reportStatus: ReportStatusType? {
        get {
            return CastOptional<ReportStatusType>.from(self.optionalValue(for: ExpenseReportItemType.reportStatus))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseReportItemType.reportStatus, to: value)
        }
    }

    open var reportend: LocalDateTime? {
        get {
            return LocalDateTime.castOptional(self.optionalValue(for: ExpenseReportItemType.reportend))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseReportItemType.reportend, to: value)
        }
    }

    open var reportid: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ExpenseReportItemType.reportid))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseReportItemType.reportid, to: StringValue.of(optional: value))
        }
    }

    open var reportlocation: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ExpenseReportItemType.reportlocation))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseReportItemType.reportlocation, to: StringValue.of(optional: value))
        }
    }

    open var reportname: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ExpenseReportItemType.reportname))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseReportItemType.reportname, to: StringValue.of(optional: value))
        }
    }

    open var reportstart: LocalDateTime? {
        get {
            return LocalDateTime.castOptional(self.optionalValue(for: ExpenseReportItemType.reportstart))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseReportItemType.reportstart, to: value)
        }
    }

    open var reportstatusid: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ExpenseReportItemType.reportstatusid))
        }
        set(value) {
            self.setOptionalValue(for: ExpenseReportItemType.reportstatusid, to: StringValue.of(optional: value))
        }
    }
}
