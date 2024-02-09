import Foundation

// MARK: - View
/// Presenter -> ViewController
protocol ReviewViewProtocol: ViewProtocol {
    var presenter: ReviewPresenterProtocol? { get set }
}

// MARK: - Interactor
/// Presenter -> Interactor
protocol ReviewInteractorInputProtocol: AnyObject {
    var presenter: ReviewInteractorOutputProtocol? { get set }
    
    func updateEmployeeInformation(employee: EmployeeModel)
}

/// Interactor -> Presenter
protocol ReviewInteractorOutputProtocol: AnyObject {
    func didUpdateEmployees(employee: EmployeeModel)
    func onUpdateEmployeeFailure()
}

// MARK: - Presenter
/// ViewController -> Presenter
protocol ReviewPresenterProtocol: AnyObject, ViewControllerLifeCycle {
    var interactor: ReviewInteractorInputProtocol? { get set }
    var sections: [CollectionViewSection] { get }
    
    func didTabSubmitButton()
}

// MARK: - Router
/// Navigation
protocol ReviewRouterProtocol: AnyObject {
    func navigateToSuccessScreen(employee: EmployeeModel)
}
