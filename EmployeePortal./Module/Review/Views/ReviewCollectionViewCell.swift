import UIKit

class ReviewCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var personalDetailStackView: UIStackView!
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var fullnameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var dateOfBirthLabel: UILabel!
    @IBOutlet private weak var genderLabel: UILabel!
    @IBOutlet private weak var additionalInformationStackView: UIStackView!
    @IBOutlet private weak var colorLabel: UILabel!
    @IBOutlet private weak var placeOfBirthLabel: UILabel!
    @IBOutlet private weak var residentialAddressLabel: UILabel!
}

extension ReviewCollectionViewCell {
    func decorate(using viewModel: ReviewViewModel) {
        backgroundColor = .white
        personalDetailStackView.makeBorder(cornerRadius: 0)
        fullnameLabel.text = viewModel.fullname
        emailLabel.text = viewModel.email
        dateOfBirthLabel.text = viewModel.dateOfBirth
        genderLabel.text = viewModel.gender
        additionalInformationStackView.makeBorder(cornerRadius: 0)
        colorLabel.text = viewModel.preferredColor
        placeOfBirthLabel.text = viewModel.placeOfBirth
        residentialAddressLabel.text = viewModel.residentialAddress
        avatarImageView.makeBorder(cornerRadius: 0)
        
        if let url = viewModel.avatar {
            avatarImageView.loadImage(using: url)
        }

        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: personalDetailStackView.leadingAnchor, constant: 8),
            colorLabel.leadingAnchor.constraint(equalTo: additionalInformationStackView.leadingAnchor, constant: 8),
            placeOfBirthLabel.leadingAnchor.constraint(equalTo: additionalInformationStackView.leadingAnchor, constant: 8),
            residentialAddressLabel.leadingAnchor.constraint(equalTo: additionalInformationStackView.leadingAnchor, constant: 8)
        ])
    }
}
