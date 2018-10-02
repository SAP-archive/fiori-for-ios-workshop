// # Proxy Compiler 18.3.3-df95fb-20180723

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
        metadata.proxyVersion = "18.3.3-df95fb-20180723"
        return metadata
    }
}
