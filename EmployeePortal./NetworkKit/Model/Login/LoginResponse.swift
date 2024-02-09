import Foundation

struct LoginResponse: Codable {
    public let page: Int?
    public let perPage: Int?
    public let total: Int?
    public let totalPages: Int?
    public let data: [LoginData]?

    init(page: Int? = nil,
         perPage: Int? = nil,
         total: Int? = nil,
         totalPages: Int? = nil,
         data: [LoginData]? = nil) {
        self.page = page
        self.perPage = perPage
        self.total = total
        self.totalPages = totalPages
        self.data = data
    }

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case data
    }
}

struct LoginData: Codable {
    public let id: Int?
    public let name: String?
    public let year: Int?
    public let color: String?
    public let pantoneValue: String?

    init(id: Int? = nil,
         name: String? = nil,
         year: Int? = nil,
         color: String? = nil,
         pantoneValue: String? = nil) {
        self.id = id
        self.name = name
        self.year = year
        self.color = color
        self.pantoneValue = pantoneValue
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case year
        case color
        case pantoneValue = "pantone_value"
    }
}
