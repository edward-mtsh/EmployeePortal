import Foundation

final class LoginInteractor {
    // MARK: - LoginInteractorInputProtocol

    weak var presenter: LoginInteractorOutputProtocol?
    private let service: NetworkKitProtocol

    // MARK: - Properties

    init(service: NetworkKitProtocol) {
        self.service = service
    }
}

// MARK: - LoginInteractorInputProtocol

extension LoginInteractor: LoginInteractorInputProtocol {
    func login(username: String, password: String) {
        service.dataTask(for: LoginResponse.self, route: LoginRoute.path){ [weak self] result, error in
            if result != nil {
                DispatchQueue.main.async {
                    self?.presenter?.didLoginSuccessfully()
                }
            } else {
                DispatchQueue.main.async {
                    self?.presenter?.onLoginFailure()
                }
            }
        }
    }
}
