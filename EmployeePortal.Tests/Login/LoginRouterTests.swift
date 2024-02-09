@testable import EmployeePortal_
import UIKit
import XCTest

class LoginRouterTests: XCTestCase {
    // MARK: - Properties

    var router: LoginRouter!
    var viewController: MockLoginViewController!

    // MARK: - Lifecycle

    override func setUp() {
        viewController = MockLoginViewController()
        router = LoginRouter()
        router.viewController = viewController
    }

    // MARK: - Test Methods
}
