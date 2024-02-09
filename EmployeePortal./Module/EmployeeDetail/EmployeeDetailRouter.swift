import UIKit

final class EmployeeDetailRouter {
    weak var viewController: UIViewController?
}

// MARK: - EmployeeDetailRouterProtocol

extension EmployeeDetailRouter: EmployeeDetailRouterProtocol {
    func navigateToEmployeeList(delegate: EmployeeListPresenterDelegate?) {
        let employeeListModule = EmployeeListModule.build(delegate: delegate)
        let navigationController = UINavigationController(rootViewController: employeeListModule)
        
        viewController?.present(navigationController, animated: true)
    }

    func navigateToAdditionalInformation(employee: EmployeeModel) {
        let additionalInformationModule = AdditionalInformationModule.build(employee: employee)
        viewController?.navigationController?.pushViewController(additionalInformationModule, animated: true)
    }
}
