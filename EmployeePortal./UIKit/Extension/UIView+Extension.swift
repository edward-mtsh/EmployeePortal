
import UIKit

extension UIView {
    func makeBorder(cornerRadius: CGFloat = 6, borderColor: UIColor = .black, borderWidth: CGFloat = 1) {
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
    }
}
