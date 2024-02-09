import UIKit

final class ReviewRouter {
    weak var viewController: UIViewController?
}

// MARK: - ReviewRouterProtocol

extension ReviewRouter: ReviewRouterProtocol {
    func navigateToSuccessScreen(employee: EmployeeModel) {
        let successModule = SuccessModule.build(employee: employee)
        let navigationController = UINavigationController(rootViewController: successModule)
        navigationController.modalPresentationStyle = .fullScreen

        viewController?.present(navigationController, animated: true)
    }
}
