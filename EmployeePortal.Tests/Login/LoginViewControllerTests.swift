@testable import EmployeePortal_
import XCTest

class LoginViewControllerTests: XCTestCase {
    // MARK: - Properties
    
    var view: LoginViewController!
    var presenter: MockLoginPresenter!
    
    // MARK: - Lifecycle
    
    override func setUp() {
        view = LoginViewController()
        view.loadViewIfNeeded()
        presenter = MockLoginPresenter()
        view.presenter = presenter
    }
    
    // MARK: - Test Methods
    
}
