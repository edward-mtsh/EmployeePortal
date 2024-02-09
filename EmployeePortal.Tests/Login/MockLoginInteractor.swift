@testable import EmployeePortal_

class MockLoginInteractor {
    // MARK: - Properties

    var presenter: LoginInteractorOutputProtocol?
    private let service: NetworkKitProtocol
    
    // MARK: - Test Properties

    init(service: NetworkKitProtocol) {
        self.service = service
    }
}

// MARK: - LoginInteractorInputProtocol

extension MockLoginInteractor: LoginInteractorInputProtocol {
    func login(username: String, password: String) {
        service.dataTask(for: LoginResponse.self, route: LoginRoute.path){ [weak self] result, error in
            if error == nil {
               self?.presenter?.didLoginSuccessfully()
            } else {
                self?.presenter?.onLoginFailure()
            }
        }
    }
}
