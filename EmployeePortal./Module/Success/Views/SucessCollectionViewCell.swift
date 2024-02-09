import UIKit

class SucessCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var successLabel: UILabel!
}

extension SucessCollectionViewCell {
    func decorate(using viewModel: SuccessViewModel) {
        backgroundColor = .white
        successLabel.text = viewModel.success
    }
}
