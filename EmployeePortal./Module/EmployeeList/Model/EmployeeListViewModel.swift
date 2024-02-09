import Foundation

struct EmployeeListViewModel {
    let avatar: URL
    let fullname: String
    let email: String

    init(avatar: URL, fullname: String, email: String) {
        self.avatar = avatar
        self.fullname = fullname
        self.email = email
    }
}
