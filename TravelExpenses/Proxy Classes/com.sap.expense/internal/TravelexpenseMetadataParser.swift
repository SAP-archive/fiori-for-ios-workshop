// # Proxy Compiler 18.9.2-6abc59-20180924

import Foundation
import SAPOData

internal class TravelexpenseMetadataParser {
    internal static let options: Int = (CSDLOption.allowCaseConflicts | CSDLOption.disableFacetWarnings | CSDLOption.disableNameValidation | CSDLOption.processMixedVersions | CSDLOption.retainOriginalText | CSDLOption.ignoreUndefinedTerms)

    internal static let parsed: CSDLDocument = TravelexpenseMetadataParser.parse()

    static func parse() -> CSDLDocument {
        let parser: CSDLParser = CSDLParser()
        parser.logWarnings = false
        parser.csdlOptions = TravelexpenseMetadataParser.options
        let metadata: CSDLDocument = parser.parseInProxy(TravelexpenseMetadataText.xml, url: "codejam.saptravelexpense.services")
        metadata.proxyVersion = "18.9.2-6abc59-20180924"
        return metadata
    }
}
