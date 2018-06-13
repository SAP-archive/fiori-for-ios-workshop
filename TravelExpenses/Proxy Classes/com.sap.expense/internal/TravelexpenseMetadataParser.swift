// # Proxy Compiler 18.3.1-fe2cc6-20180517

import Foundation
import SAPOData

internal class TravelexpenseMetadataParser {
    internal static let options: Int = (CSDLOption.processMixedVersions | CSDLOption.retainOriginalText | CSDLOption.ignoreUndefinedTerms)

    internal static let parsed: CSDLDocument = TravelexpenseMetadataParser.parse()

    static func parse() -> CSDLDocument {
        let parser: CSDLParser = CSDLParser()
        parser.logWarnings = false
        parser.csdlOptions = TravelexpenseMetadataParser.options
        let metadata: CSDLDocument = parser.parseInProxy(TravelexpenseMetadataText.xml, url: "codejam.saptravelexpense.services")
        metadata.proxyVersion = "18.3.1-fe2cc6-20180517"
        return metadata
    }
}
