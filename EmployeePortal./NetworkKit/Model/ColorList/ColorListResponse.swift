import Foundation

struct ColorListResponse: Codable {
    let page: Int?
    let perPage: Int?
    let total: Int?
    let totalPages: Int?
    let data: [ColorModel]?

    init(page: Int?, perPage: Int?, total: Int?, totalPages: Int?, data: [ColorModel]?) {
        self.page = page
        self.perPage = perPage
        self.total = total
        self.totalPages = totalPages
        self.data = data
    }
}

struct ColorModel: Codable {
    let id: Int?
    let name: String?
    let year: Int?
    let color: String?
    let pantoneValue: String?

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
