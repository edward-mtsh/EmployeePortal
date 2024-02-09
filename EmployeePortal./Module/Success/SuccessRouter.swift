import UIKit

final class SuccessRouter {
    weak var viewController: UIViewController?
}

// MARK: - SuccessRouterProtocol

extension SuccessRouter: SuccessRouterProtocol {
    func navigateToEmployeeDetail(employee: EmployeeModel) {
        let employeeDetailModule = EmployeeDetailModule.build(employee: employee)
        viewController?.navigationController?.pushViewController(employeeDetailModule, animated: true)
    }
}
