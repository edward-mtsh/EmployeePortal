import Foundation

// MARK: - View
/// Presenter -> ViewController
protocol EmployeeListViewProtocol: ViewProtocol {
    var presenter: EmployeeListPresenterProtocol? { get set }
}

// MARK: - Interactor
/// Presenter -> Interactor
protocol EmployeeListInteractorInputProtocol: AnyObject {
    var presenter: EmployeeListInteractorOutputProtocol? { get set }

    func fetchEmployeeList()
}

/// Interactor -> Presenter
protocol EmployeeListInteractorOutputProtocol: AnyObject {
    func didFetchEmployees(employees: [EmployeeModel])
    func onEmployeeListFetchFailure()
}

// MARK: - Presenter
/// ViewController -> Presenter
protocol EmployeeListPresenterProtocol: AnyObject, ViewControllerLifeCycle {
    var interactor: EmployeeListInteractorInputProtocol? { get set }
    var employeeList: [EmployeeModel] { get }

    func didSelectEmployee(at indexPath: IndexPath)
    func makeViewModel(using indexPath: IndexPath) -> EmployeeListViewModel?
}

// MARK: - Router
/// Navigation
protocol EmployeeListRouterProtocol: AnyObject {
}
