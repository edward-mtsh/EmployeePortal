import UIKit

class AdditionalInformationCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var colorView: UIView!
    @IBOutlet private weak var segmentControl: UISegmentedControl!
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var colorNameLabel: UILabel!
    @IBOutlet private weak var chevronButton: UIButton!
    @IBOutlet private weak var addressTextField: UITextField!

    var actionHandler: (() -> Void)?
    var editingChangedHandler: ((_ text: String) -> Void)?
    var valueChangedHandler: ((_ text: String) -> Void)?

    @IBAction
    private func onButtonTapped(_ sender: Any) {
        actionHandler?()
    }
}

extension AdditionalInformationCollectionViewCell {
    func decorate(using viewModel: AdditionalInformationViewModel) {
        backgroundColor = .white
        segmentControl.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
        colorNameLabel.text = viewModel.name
        addressTextField.makeBorder(cornerRadius: 0)
        addressTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        stackView.makeBorder(cornerRadius: 0)
        colorView.makeBorder(cornerRadius: 13, borderWidth: 0)
        colorView.backgroundColor = viewModel.color
        chevronButton.setTitle("", for: .normal)

        NSLayoutConstraint.activate([
            colorView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 8)
        ])
    }
}

private extension AdditionalInformationCollectionViewCell {
    @objc private func editingChanged() {
        guard let text = addressTextField.text else { return }

        editingChangedHandler?(text)
    }

    @objc private func valueChanged() {
        guard let title = segmentControl.titleForSegment(at: segmentControl.selectedSegmentIndex) else { return }

        valueChangedHandler?(title)
    }
}
