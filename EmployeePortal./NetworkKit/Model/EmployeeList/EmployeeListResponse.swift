import Foundation

struct EmployeeListResponse: Codable {
    let page: Int?
    let perPage: Int?
    let total: Int?
    let totalPages: Int?
    let data: [EmployeeModel]?

    init(page: Int?, perPage: Int?, total: Int?, totalPages: Int?, data: [EmployeeModel]?) {
        self.page = page
        self.perPage = perPage
        self.total = total
        self.totalPages = totalPages
        self.data = data
    }
}

struct EmployeeModel: Codable {
    let id: Int?
    let email: String?
    let firstName: String?
    let lastName: String?
    let avatar: String?
    let dateOfBirth: String?
    let gender: String?
    let placeOfBirth: String?
    let preferredColor: String?
    let preferredColorName: String?
    let residentialAddress: String?
    var createAt: String?

    init(id: Int? = nil,
         email: String? = nil,
         firstName: String? = nil,
         lastName: String? = nil,
         avatar: String? = nil,
         dateOfBirth: String? = nil,
         gender: String? = nil,
         placeOfBirth: String? = nil,
         preferredColor: String? = nil,
         preferredColorName: String? = nil,
         residentialAddress: String? = nil) {
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.avatar = avatar
        self.dateOfBirth = dateOfBirth
        self.gender = gender
        self.placeOfBirth = placeOfBirth
        self.preferredColor = preferredColor
        self.preferredColorName = preferredColorName
        self.residentialAddress = residentialAddress
    }

    enum CodingKeys: String, CodingKey {
        case id
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
        case dateOfBirth = "DOB"
        case gender
        case placeOfBirth = "placeOfBirth"
        case preferredColor
        case preferredColorName
        case residentialAddress
    }
}
