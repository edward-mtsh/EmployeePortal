import Foundation

protocol RouteProviding {
    var path: String { get }
    var url: URL { get }
    var httpMethod: String { get }
    var headers: [String: String] { get }
    var body: Data? { get }
}

extension RouteProviding {
    var headers: [String: String] {
        var headers = [String: String]()
        headers["Content-Type"] = "application/json"
        headers["Accept"] = "application/json"
        return headers
    }

    func encode<T: Encodable>(_ value: T) -> Data? {
        do {
            let jsonEncoder = JSONEncoder()
            return try jsonEncoder.encode(value)
        } catch {
            return nil
        }
    }
}

protocol NetworkKitProtocol {
    func dataTask<Model>(for model: Model.Type,
                         route: RouteProviding,
                         completion: @escaping (Model?, Error?) -> Void) where Model: Decodable, Model: Encodable
}

final public class NetworkKit: NSObject, NetworkKitProtocol {
    func dataTask<Model>(for model: Model.Type,
                         route: RouteProviding,
                         completion: @escaping (Model?, Error?) -> Void) where Model: Decodable, Model: Encodable {
        let request = urlRequestWithHeaders(for: route)

        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else { return }

            do {
                let object = try JSONDecoder().decode(model.self, from: data)
                completion(object, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}

private extension NetworkKit {
    private func urlRequestWithHeaders(for route: RouteProviding) -> URLRequest {
        var request = URLRequest(url: route.url)
        request.httpMethod = route.httpMethod
        route.headers.forEach({
            request.setValue($0.value, forHTTPHeaderField: $0.key)
        })

        if let body = route.body {
            request.httpBody = body
        }

        return request
    }
}
