import Foundation

final class EmployeeListInteractor {
    // MARK: - EmployeeListInteractorInputProtocol

    weak var presenter: EmployeeListInteractorOutputProtocol?

    private let service: NetworkKitProtocol

    // MARK: - Properties

    init(service: NetworkKitProtocol) {
        self.service = service
    }
}

// MARK: - EmployeeListInteractorInputProtocol

extension EmployeeListInteractor: EmployeeListInteractorInputProtocol {
    func fetchEmployeeList() {
        service.dataTask(for: EmployeeListResponse.self, route: EmployeeListRoute.path){ [weak self] result, error in
            if let employees = result?.data {
                DispatchQueue.main.async {
                    self?.presenter?.didFetchEmployees(employees: employees)
                }
            } else {
                DispatchQueue.main.async {
                    self?.presenter?.onEmployeeListFetchFailure()
                }
            }
        }
    }
}
