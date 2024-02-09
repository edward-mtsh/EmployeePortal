import Foundation

struct EmployeeDetailViewModel: Hashable {
    let fullname: String
    let email: String
    let dateOfBirth: String
    let location: String
    let avatar: URL?

    init(fullname: String, email: String, dateOfBirth: String, location: String, avatar: URL? = nil) {
        self.fullname = fullname
        self.email = email
        self.dateOfBirth = dateOfBirth
        self.location = location
        self.avatar = avatar
    }
}
