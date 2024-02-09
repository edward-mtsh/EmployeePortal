@testable import EmployeePortal_
import XCTest

class LoginInteractorTests: XCTestCase {
    // MARK: - Properties
    
    var interactor: LoginInteractor!
    var presenter: MockLoginPresenter!
    
    // MARK: - Lifecycle
    
    override func setUp() {
        presenter = MockLoginPresenter()
        interactor = LoginInteractor(service: MockNetworkKit())
        interactor.presenter = presenter
    }
    
    // MARK: - Test Methods
    
}
