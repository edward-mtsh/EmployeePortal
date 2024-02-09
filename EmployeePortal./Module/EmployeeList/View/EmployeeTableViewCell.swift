import UIKit

class EmployeeTableViewCell: UITableViewCell {
    @IBOutlet private weak var avatarView: UIImageView!
    @IBOutlet private weak var fullname: UILabel!
    @IBOutlet private weak var email: UILabel!
}

extension EmployeeTableViewCell {
    func decorate(using viewModel: EmployeeListViewModel) {
        avatarView.loadImage(using: viewModel.avatar)
        fullname.text = viewModel.fullname
        email.text = viewModel.email
    }
}
