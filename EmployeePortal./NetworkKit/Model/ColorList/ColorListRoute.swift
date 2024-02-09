import Foundation

enum ColorListRoute {
    case path
}

extension ColorListRoute: RouteProviding {
    var path: String {
        "https://reqres.in/api/unknown?per_page=12"
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
