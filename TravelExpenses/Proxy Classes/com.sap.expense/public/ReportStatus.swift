// # Proxy Compiler 18.9.2-6abc59-20180924

import Foundation
import SAPOData

open class ReportStatus: EntityValue {
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }

    private static var reportstatusid_: Property = TravelexpenseMetadata.EntityTypes.reportStatus.property(withName: "REPORTSTATUSID")

    private static var description_: Property = TravelexpenseMetadata.EntityTypes.reportStatus.property(withName: "DESCRIPTION")

    public init(withDefaults: Bool = true) {
        super.init(withDefaults: withDefaults, type: TravelexpenseMetadata.EntityTypes.reportStatus)
    }

    open class func array(from: EntityValueList) -> Array<ReportStatus> {
        return ArrayConverter.convert(from.toArray(), Array<ReportStatus>())
    }

    open func copy() -> ReportStatus {
        return CastRequired<ReportStatus>.from(self.copyEntity())
    }

    open class var description: Property {
        get {
            objc_sync_enter(ReportStatus.self)
            defer { objc_sync_exit(ReportStatus.self) }
            do {
                return ReportStatus.description_
            }
        }
        set(value) {
            objc_sync_enter(ReportStatus.self)
            defer { objc_sync_exit(ReportStatus.self) }
            do {
                ReportStatus.description_ = value
            }
        }
    }

    open var description: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ReportStatus.description))
        }
        set(value) {
            self.setOptionalValue(for: ReportStatus.description, to: StringValue.of(optional: value))
        }
    }

    open override var isProxy: Bool {
        return true
    }

    open class func key(reportstatusid: String?) -> EntityKey {
        return EntityKey().with(name: "REPORTSTATUSID", value: StringValue.of(optional: reportstatusid))
    }

    open var old: ReportStatus {
        return CastRequired<ReportStatus>.from(self.oldEntity)
    }

    open class var reportstatusid: Property {
        get {
            objc_sync_enter(ReportStatus.self)
            defer { objc_sync_exit(ReportStatus.self) }
            do {
                return ReportStatus.reportstatusid_
            }
        }
        set(value) {
            objc_sync_enter(ReportStatus.self)
            defer { objc_sync_exit(ReportStatus.self) }
            do {
                ReportStatus.reportstatusid_ = value
            }
        }
    }

    open var reportstatusid: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ReportStatus.reportstatusid))
        }
        set(value) {
            self.setOptionalValue(for: ReportStatus.reportstatusid, to: StringValue.of(optional: value))
        }
    }
}
