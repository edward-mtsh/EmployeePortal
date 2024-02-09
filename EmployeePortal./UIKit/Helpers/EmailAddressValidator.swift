import Foundation

protocol EmailAddressValidatable {
    func validate(_ value: String) throws -> String
}

struct EmailAddressValidator: EmailAddressValidatable {
    private let domain = "Employee_InputValidation"

    func validate(_ value: String) throws -> String {
        let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)

        let range = NSRange(
            value.startIndex..<value.endIndex,
            in: value
        )

        let matches = detector?.matches(
            in: value,
            options: [],
            range: range
        )

        // We only want our string to contain a single email
        // address, so if multiple matches were found, then
        // we fail our validation process
        guard let match = matches?.first, matches?.count == 1 else {
            let userInfo: [String: Any] = [NSLocalizedDescriptionKey: NSLocalizedString("Invalid Email address", comment: "")]
            throw NSError(domain: domain, code: 1, userInfo: userInfo)
        }

        // Verify that the found link points to an email address,
        // and that its range covers the whole input string:
        guard match.url?.scheme == "mailto", match.range == range else {
            let userInfo: [String: Any] = [NSLocalizedDescriptionKey: NSLocalizedString("Invalid Email address", comment: "")]
            throw NSError(domain: domain, code: 1, userInfo: userInfo)
        }

        return value
    }
}

