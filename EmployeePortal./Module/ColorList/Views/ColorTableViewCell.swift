import UIKit

class ColorTableViewCell: UITableViewCell {
    @IBOutlet private weak var stackView: UIView!
    @IBOutlet private weak var colorView: UIView!
    @IBOutlet private weak var nameLabel: UILabel!

    private var viewModel: ColorListViewModel?
}

extension ColorTableViewCell {
    func decorate(using viewModel: ColorListViewModel) {
        self.viewModel = viewModel
        colorView.backgroundColor = viewModel.color
        colorView.makeBorder(cornerRadius: 10, borderWidth: 0)
        nameLabel.text = viewModel.name

        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalToConstant: 40),
            colorView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16)
        ])
    }
}
