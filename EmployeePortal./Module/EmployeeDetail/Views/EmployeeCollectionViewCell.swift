import UIKit

class EmployeeCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var fullnameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var chevronButton: UIButton!
    @IBOutlet private weak var dateOfBirthTextField: UITextField!
    @IBOutlet private weak var locationTextField: UITextField!
    @IBOutlet private weak var stackView: UIStackView!

    var actionHandler: (() -> Void)?
    var editingChangedHandler: ((_ text: String) -> Void)?
    var dateChangedHandler: ((_ text: String) -> Void)?
    let datePickerView: UIDatePicker = UIDatePicker()

    @IBAction
    private func onButtonTapped(_ sender: Any) {
        actionHandler?()
    }
}

extension EmployeeCollectionViewCell {
    func decorate(using viewModel: EmployeeDetailViewModel) {
        backgroundColor = .white
        fullnameLabel.text = viewModel.fullname
        emailLabel.text = viewModel.email
        dateOfBirthTextField.text = viewModel.dateOfBirth
        dateOfBirthTextField.makeBorder(cornerRadius: 0)
        datePickerView.datePickerMode = .date
        dateOfBirthTextField.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        locationTextField.makeBorder(cornerRadius: 0)
        locationTextField.text = viewModel.location
        locationTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        stackView.makeBorder(cornerRadius: 0)
        imageView.makeBorder(cornerRadius: 0)
        chevronButton.setTitle("", for: .normal)
        
        if let url = viewModel.avatar {
            imageView.loadImage(using: url)
        }

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 4)
        ])
    }
}

private extension EmployeeCollectionViewCell {
    @objc private func editingChanged() {
        guard let text = locationTextField.text else { return }

        editingChangedHandler?(text)
    }

    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateFormat = "YYYY-MM-dd"
        dateOfBirthTextField.text = dateFormatter.string(from: sender.date)
        dateChangedHandler?(dateFormatter.string(from: sender.date))
    }
}
