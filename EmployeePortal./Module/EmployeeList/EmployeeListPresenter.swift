import Foundation

protocol EmployeeListPresenterDelegate: AnyObject {
    func didSelectEmployee(employee: EmployeeModel)
}

final class EmployeeListPresenter {
    // MARK: - EmployeeListPresenterProtocol

    var interactor: EmployeeListInteractorInputProtocol?
    var employeeList: [EmployeeModel] = []
    weak var delegate: EmployeeListPresenterDelegate?

    // MARK: - Properties

    weak private var view: EmployeeListViewProtocol?
    private let router: EmployeeListRouterProtocol

    // MARK: - Lifecycle

    init(interface: EmployeeListViewProtocol, interactor: EmployeeListInteractorInputProtocol?, router: EmployeeListRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - EmployeeListPresenterProtocol

extension EmployeeListPresenter: EmployeeListPresenterProtocol {
    func viewDidLoad() {
        view?.showLoader()
        interactor?.fetchEmployeeList()
    }

    func didSelectEmployee(at indexPath: IndexPath) {
        if let employee = employeeList.element(at: indexPath.row) {
            delegate?.didSelectEmployee(employee: employee)
            view?.dismissView()
        }
    }

    func makeViewModel(using indexPath: IndexPath) -> EmployeeListViewModel? {
        if let employee = employeeList.element(at: indexPath.row) {
            guard let url = URL(string: employee.avatar ?? ""),
                  let firstName = employee.firstName,
                  let lastName = employee.lastName,
                  let email = employee.email else { return nil }

            return EmployeeListViewModel(
                avatar: url,
                fullname: "\(firstName) \(lastName)",
                email: email
            )
        }

        return nil
    }
}

// MARK: - EmployeeListInteractorOutputProtocol

extension EmployeeListPresenter: EmployeeListInteractorOutputProtocol {
    func didFetchEmployees(employees: [EmployeeModel]) {
        view?.hideLoader()

        employees.forEach { employee in
            employeeList.append(
                EmployeeModel(
                    id: employee.id,
                    email: employee.email,
                    firstName: employee.firstName,
                    lastName: employee.lastName,
                    avatar: employee.avatar,
                    dateOfBirth: employee.dateOfBirth,
                    gender: employee.gender
                )
            )
        }

        view?.decorate()
    }

    func onEmployeeListFetchFailure() {
        view?.hideLoader()
    }
}
