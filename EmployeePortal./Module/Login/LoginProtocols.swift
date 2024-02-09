import Foundation

// MARK: - View
/// Presenter -> ViewController
protocol LoginViewProtocol: ViewProtocol {
    var presenter: LoginPresenterProtocol? { get set }
}

// MARK: - Interactor
/// Presenter -> Interactor
protocol LoginInteractorInputProtocol: AnyObject {
    var presenter: LoginInteractorOutputProtocol? { get set }

    func login(username: String, password: String)
}

/// Interactor -> Presenter
protocol LoginInteractorOutputProtocol: AnyObject {
    func didLoginSuccessfully()
    func onLoginFailure()
}

// MARK: - Presenter
/// ViewController -> Presenter
protocol LoginPresenterProtocol: AnyObject, ViewControllerLifeCycle {
    var interactor: LoginInteractorInputProtocol? { get set }

    func validate(username: String, password: String)
}

// MARK: - Router
/// Navigation
protocol LoginRouterProtocol: AnyObject {
    func showError(title: String, message: String, buttonTitle: String)
    func navigateToEmployeeDetail()
}
