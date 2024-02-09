import Foundation
@testable import EmployeePortal_

struct MockNetworkKit: NetworkKitProtocol {
    let hasError: Bool

    init(hasError: Bool = false) {
        self.hasError = hasError
    }

    func dataTask<Model>(for model: Model.Type, route: RouteProviding, completion: @escaping (Model?, Error?) -> Void) where Model : Decodable, Model : Encodable {
        if hasError == true {
            completion(nil, NSError(domain: "", code: 400))
        } else {
            completion(nil, nil)
        }
    }
}
