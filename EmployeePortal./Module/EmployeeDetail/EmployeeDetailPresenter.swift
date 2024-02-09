import Foundation

final class EmployeeDetailPresenter {
    // MARK: - EmployeeDetailPresenterProtocol

    var interactor: EmployeeDetailInteractorInputProtocol?
    var sections: [CollectionViewSection] = []

    // MARK: - Properties

    weak private var view: EmployeeDetailViewProtocol?
    private let router: EmployeeDetailRouterProtocol
    var employee: EmployeeModel?
    private var dateOfBirth: String?
    private var placeOfBirth: String?

    // MARK: - Lifecycle

    init(interface: EmployeeDetailViewProtocol, 
         interactor: EmployeeDetailInteractorInputProtocol?,
         router: EmployeeDetailRouterProtocol,
         employee: EmployeeModel?) {
        self.view = interface
        self.interactor = interactor
        self.router = router
        self.employee = employee
    }
}

// MARK: - EmployeeDetailPresenterProtocol

extension EmployeeDetailPresenter: EmployeeDetailPresenterProtocol {
    func viewDidLoad() {
        dateOfBirth = employee?.dateOfBirth
        placeOfBirth = employee?.placeOfBirth
        sections = makeSections(employee: employee)
        view?.decorate()
    }

    func navigateToEmployeeList() {
        router.navigateToEmployeeList(delegate: self)
    }

    func navigateToAdditionalInformation() {
        guard let employee else { return }

        let employeeModel = EmployeeModel(
            id: employee.id,
            email: employee.email,
            firstName: employee.firstName,
            lastName: employee.lastName,
            avatar: employee.avatar,
            dateOfBirth: dateOfBirth,
            placeOfBirth: placeOfBirth
        )

        router.navigateToAdditionalInformation(employee: employeeModel)
    }

    func updateDateOfBirth(dateOfBirth: String) {
        self.dateOfBirth = dateOfBirth
    }

    func updatePlaceOfBirth(placeOfBirth: String) {
        self.placeOfBirth = placeOfBirth
    }
}

// MARK: - EmployeeDetailInteractorOutputProtocol

extension EmployeeDetailPresenter: EmployeeDetailInteractorOutputProtocol {
}

private extension EmployeeDetailPresenter {
    func makeSections(employee: EmployeeModel?) -> [CollectionViewSection] {
        let section = CollectionViewSection(
            title: "",
            items: [
                EmployeeDetailViewModel(
                    fullname: "\(employee?.firstName ?? "Full Name") \(employee?.lastName ?? "")",
                    email: employee?.email ?? "Email",
                    dateOfBirth: employee?.dateOfBirth ?? "",
                    location: employee?.placeOfBirth ?? "",
                    avatar: URL(string: employee?.avatar ?? "")
                )
            ]
        )

        sections.append(section)
        return sections
    }
}

extension EmployeeDetailPresenter: EmployeeListPresenterDelegate {
    func didSelectEmployee(employee: EmployeeModel) {
        sections.removeAll()
        self.employee = employee
        sections = makeSections(employee: employee)
        view?.decorate()
        view?.addRightNavigationBarButton()
    }
}
