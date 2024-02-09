import UIKit

final class AdditionalInformationRouter {
    weak var viewController: UIViewController?
}

// MARK: - AdditionalInformationRouterProtocol

extension AdditionalInformationRouter: AdditionalInformationRouterProtocol {
    func navigateToColorList(delegate: ColorListPresenterDelegate?) {
        let colorListModule = ColorListModule.build(delegate: delegate)
        let navigationController = UINavigationController(rootViewController: colorListModule)
        
        viewController?.present(navigationController, animated: true)
    }

    func navigateToReview(employee: EmployeeModel) {
        let reviewModule = ReviewModule.build(employee: employee)
        viewController?.navigationController?.pushViewController(reviewModule, animated: true)
    }
}
