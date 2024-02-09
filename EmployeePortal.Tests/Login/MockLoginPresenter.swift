@testable import EmployeePortal_

class MockLoginPresenter {
    // MARK: - Properties
    
    var interactor: LoginInteractorInputProtocol?
    var view: LoginViewProtocol?
    var router: LoginRouterProtocol = MockLoginRouter()
    
    // MARK: - Test Properties

}

// MARK: - LoginPresenterProtocol

extension MockLoginPresenter: LoginPresenterProtocol {
    func validate(username: String, password: String) {
        
    }
}

// MARK: - LoginInteractorOutputProtocol

extension MockLoginPresenter: LoginInteractorOutputProtocol {
    func didLoginSuccessfully() {
        
    }
    
    func onLoginFailure() {
        
    }
}
