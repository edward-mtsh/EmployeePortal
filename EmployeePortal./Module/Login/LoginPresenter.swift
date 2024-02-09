import Foundation

final class LoginPresenter {
    // MARK: - LoginPresenterProtocol

    var interactor: LoginInteractorInputProtocol?

    // MARK: - Properties

    weak private var view: LoginViewProtocol?
    private var passwordCharacterLimit = 10
    private let router: LoginRouterProtocol
    private let emailAddressValidator: EmailAddressValidatable

    // MARK: - Lifecycle

    init(interface: LoginViewProtocol,
         interactor: LoginInteractorInputProtocol?,
         router: LoginRouterProtocol,
         emailAddressValidator: EmailAddressValidatable) {
        self.view = interface
        self.interactor = interactor
        self.router = router
        self.emailAddressValidator = emailAddressValidator
    }
}

// MARK: - LoginPresenterProtocol

extension LoginPresenter: LoginPresenterProtocol {
    func validate(username: String, password: String) {
        do {
            let emailAddress = try emailAddressValidator.validate(username)

            if password.count >= passwordCharacterLimit {
                view?.showLoader()
                interactor?.login(username: emailAddress, password: password)
            } else {
                router.showError(title: .alert, message: .passwordLimit, buttonTitle: .buttonTitle)
            }
        } catch {
            router.showError(title: .alert, message: .invalidEmail, buttonTitle: .buttonTitle)
        }
    }
}

// MARK: - LoginInteractorOutputProtocol

extension LoginPresenter: LoginInteractorOutputProtocol {
    func didLoginSuccessfully() {
        view?.hideLoader()
        router.navigateToEmployeeDetail()
    }

    func onLoginFailure() {
        view?.hideLoader()
        router.showError(title: .alert, message: .loginError, buttonTitle: .retryTitle)
    }
}

private extension String {
    static let alert = "Alert"
    static let passwordLimit = "Password should be 10 characters or more"
    static let invalidEmail = "Invalid email"
    static let loginError = "Could not login. Please try again"
    static let buttonTitle = "Ok"
    static let retryTitle = "Retry"
}
