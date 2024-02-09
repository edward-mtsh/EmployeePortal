@testable import EmployeePortal_
import UIKit

class MockLoginViewController: UIViewController {
    // MARK: - Properties
    
    var presenter: LoginPresenterProtocol?
    
    // MARK: - Test Properties
    var showLoaderCalled = false
    var hideLoaderCalled = false
}

// MARK: - LoginViewProtocol

extension MockLoginViewController: LoginViewProtocol {
    func decorate() {
        
    }
    
    func showLoader() {
        showLoaderCalled = true
    }

    func hideLoader() {
        hideLoaderCalled = true
    }
}
