@testable import EmployeePortal_
import UIKit

class MockLoginRouter {
    // MARK: - Properties

    var viewController: UIViewController?

    // MARK: - Test Properties
    var navigateToEmployeeDetailCalled = false
    var showErrorCalled = false
}

// MARK: - LoginRouterProtocol

extension MockLoginRouter: LoginRouterProtocol {
    func showError(title: String, message: String, buttonTitle: String) {
        showErrorCalled = true
    }

    func navigateToEmployeeDetail() {
        navigateToEmployeeDetailCalled = true
    }
}
