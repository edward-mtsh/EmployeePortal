import Foundation

struct ReviewViewModel: Hashable {
    let email: String?
    let fullname: String?
    let avatar: URL?
    let dateOfBirth: String?
    let gender: String?
    let placeOfBirth: String?
    let preferredColor: String?
    let residentialAddress: String?

    init(email: String? = nil,
         fullname: String? = nil,
         avatar: URL? = nil,
         dateOfBirth: String? = nil,
         gender: String? = nil,
         placeOfBirth: String? = nil,
         preferredColor: String? = nil,
         residentialAddress: String? = nil) {
        self.email = email
        self.fullname = fullname
        self.avatar = avatar
        self.dateOfBirth = dateOfBirth
        self.gender = gender
        self.placeOfBirth = placeOfBirth
        self.preferredColor = preferredColor
        self.residentialAddress = residentialAddress
    }
}
