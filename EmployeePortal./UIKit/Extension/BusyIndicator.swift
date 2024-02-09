import UIKit

var activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)

extension UIViewController {
    func showBusyView() {
        activityView.center = self.view.center
        activityView.color = UIColor.darkGray
        activityView.startAnimating()
        self.view.addSubview(activityView)
        let x = (UIScreen.main.bounds.width / 2)
        let y = (UIScreen.main.bounds.height / 2)
        activityView.center = CGPoint( x: x, y: y)
        view.alpha = 0.5
        view.isUserInteractionEnabled = false
    }

    func hideBusyView() {
        activityView.stopAnimating()
        activityView.isHidden = true
        activityView.removeFromSuperview()
        view.alpha = 1
        view.isUserInteractionEnabled = true
    }
}
