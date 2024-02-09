import Foundation

// MARK: - View
/// Presenter -> ViewController
protocol SuccessViewProtocol: ViewProtocol {
    var presenter: SuccessPresenterProtocol? { get set }
}

// MARK: - Interactor
/// Presenter -> Interactor
protocol SuccessInteractorInputProtocol: AnyObject {
    var presenter: SuccessInteractorOutputProtocol? { get set }
}

/// Interactor -> Presenter
protocol SuccessInteractorOutputProtocol: AnyObject {
}

// MARK: - Presenter
/// ViewController -> Presenter
protocol SuccessPresenterProtocol: AnyObject, ViewControllerLifeCycle {
    var interactor: SuccessInteractorInputProtocol? { get set }
    var sections: [CollectionViewSection] { get }

    func navigateToEmployeeDetail()
}

// MARK: - Router
/// Navigation
protocol SuccessRouterProtocol: AnyObject {
    func navigateToEmployeeDetail(employee: EmployeeModel)
}
