import Foundation

enum LoginRoute {
    case path
}

extension LoginRoute: RouteProviding {
    var path: String {
        "https://reqres.in/api/login"
    }

    var url: URL {
        URL(string: path)!
    }

    var httpMethod: String {
        "GET"
    }

    var body: Data? {
        nil
    }
}
