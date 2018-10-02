// # Proxy Compiler 18.3.3-df95fb-20180723

import Foundation
import SAPOData

open class ReportStatusType: EntityValue {
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }

    public static var reportstatusid: Property = TravelexpenseMetadata.EntityTypes.reportStatusType.property(withName: "REPORTSTATUSID")

    public static var description: Property = TravelexpenseMetadata.EntityTypes.reportStatusType.property(withName: "DESCRIPTION")

    public init(withDefaults: Bool = true) {
        super.init(withDefaults: withDefaults, type: TravelexpenseMetadata.EntityTypes.reportStatusType)
    }

    open class func array(from: EntityValueList) -> Array<ReportStatusType> {
        return ArrayConverter.convert(from.toArray(), Array<ReportStatusType>())
    }

    open func copy() -> ReportStatusType {
        return CastRequired<ReportStatusType>.from(self.copyEntity())
    }

    open var description: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ReportStatusType.description))
        }
        set(value) {
            self.setOptionalValue(for: ReportStatusType.description, to: StringValue.of(optional: value))
        }
    }

    open override var isProxy: Bool {
        return true
    }

    open class func key(reportstatusid: String?) -> EntityKey {
        return EntityKey().with(name: "REPORTSTATUSID", value: StringValue.of(optional: reportstatusid))
    }

    open var old: ReportStatusType {
        return CastRequired<ReportStatusType>.from(self.oldEntity)
    }

    open var reportstatusid: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ReportStatusType.reportstatusid))
        }
        set(value) {
            self.setOptionalValue(for: ReportStatusType.reportstatusid, to: StringValue.of(optional: value))
        }
    }
}
