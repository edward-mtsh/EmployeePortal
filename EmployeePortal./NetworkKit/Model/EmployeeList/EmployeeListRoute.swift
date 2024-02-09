import Foundation

enum EmployeeListRoute {
    case path
}

extension EmployeeListRoute: RouteProviding {
    var path: String {
        "https://reqres.in/api/users?page=1&per_page=12"
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
