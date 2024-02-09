import Foundation

enum ReviewRoute {
    case review(ReviewRequest)
}

extension ReviewRoute: RouteProviding {
    var path: String {
        "https://reqres.in/api/users"
    }

    var url: URL {
        URL(string: path)!
    }

    var httpMethod: String {
        "POST"
    }

    public var body: Data? {
        switch self {
        case let .review(request):
            return encode(request)
        }
    }
}
