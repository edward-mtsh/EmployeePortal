import Foundation

// MARK: - View
/// Presenter -> ViewController
protocol EmployeeDetailViewProtocol: ViewProtocol {
    var presenter: EmployeeDetailPresenterProtocol? { get set }

    func addRightNavigationBarButton()
}

// MARK: - Interactor
/// Presenter -> Interactor
protocol EmployeeDetailInteractorInputProtocol: AnyObject {
    var presenter: EmployeeDetailInteractorOutputProtocol? { get set }
}

/// Interactor -> Presenter
protocol EmployeeDetailInteractorOutputProtocol: AnyObject {
}

// MARK: - Presenter
/// ViewController -> Presenter
protocol EmployeeDetailPresenterProtocol: AnyObject, ViewControllerLifeCycle {
    var interactor: EmployeeDetailInteractorInputProtocol? { get set }
    var sections: [CollectionViewSection] { get }

    func navigateToEmployeeList()
    func navigateToAdditionalInformation()
    func updateDateOfBirth(dateOfBirth: String)
    func updatePlaceOfBirth(placeOfBirth: String)
}

// MARK: - Router
/// Navigation
protocol EmployeeDetailRouterProtocol: AnyObject {
    func navigateToEmployeeList(delegate: EmployeeListPresenterDelegate?)
    func navigateToAdditionalInformation(employee: EmployeeModel)
}
