import Foundation

struct ReviewRequest: Codable {
    let id: String?
    let createdAt: String?
    let userLoginToken: String?
    let personalDetails: PersonalDetailsModel?
    let additionalInformation: AdditionalInformationModel?

    init(id: String? = nil,
         createdAt: String? = nil,
         userLoginToken: String? = nil,
         personalDetails: PersonalDetailsModel? = nil,
         additionalInformation: AdditionalInformationModel? = nil) {
        self.id = id
        self.createdAt = createdAt
        self.userLoginToken = userLoginToken
        self.personalDetails = personalDetails
        self.additionalInformation = additionalInformation
    }

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt
        case userLoginToken
        case personalDetails
        case additionalInformation
    }
}

struct PersonalDetailsModel: Codable {
    let id: Int?
    let email: String?
    let firstName: String?
    let lastName: String?
    let avatar: String?
    let dateOfBirth: String?
    let gender: String?

    init(id: Int? = nil,
         email: String? = nil,
         firstName: String? = nil,
         lastName: String? = nil,
         avatar: String? = nil,
         dateOfBirth: String? = nil,
         gender: String? = nil) {
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.avatar = avatar
        self.dateOfBirth = dateOfBirth
        self.gender = gender
    }

    enum CodingKeys: String, CodingKey {
        case id
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
        case dateOfBirth = "DOB"
        case gender
    }
}

struct AdditionalInformationModel: Codable {
    let placeOfBirth: String?
    let preferredColor: String?
    let residentialAddress: String?

    init(placeOfBirth: String? = nil,
         preferredColor: String? = nil,
         residentialAddress: String? = nil) {
        self.placeOfBirth = placeOfBirth
        self.preferredColor = preferredColor
        self.residentialAddress = residentialAddress
    }

    enum CodingKeys: String, CodingKey {
        case placeOfBirth
        case preferredColor
        case residentialAddress
    }
}
