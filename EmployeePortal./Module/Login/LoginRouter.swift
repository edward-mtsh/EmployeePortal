import UIKit

final class LoginRouter {
    weak var viewController: UIViewController?
}

// MARK: - LoginRouterProtocol

extension LoginRouter: LoginRouterProtocol {
    func showError(title: String, message: String, buttonTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
        viewController?.present(alert, animated: true, completion: nil)
    }

    func navigateToEmployeeDetail() {
        let employeeDetailModule = EmployeeDetailModule.build(employee: nil)
        viewController?.navigationController?.pushViewController(employeeDetailModule, animated: true)
    }
}
