import Foundation

final class SuccessPresenter {
    // MARK: - SuccessPresenterProtocol

    var interactor: SuccessInteractorInputProtocol?
    var sections: [CollectionViewSection] = []

    // MARK: - Properties

    weak private var view: SuccessViewProtocol?
    private let router: SuccessRouterProtocol
    private let employee: EmployeeModel

    // MARK: - Lifecycle

    init(interface: SuccessViewProtocol, 
         interactor: SuccessInteractorInputProtocol?,
         router: SuccessRouterProtocol,
         employee: EmployeeModel) {
        self.view = interface
        self.interactor = interactor
        self.router = router
        self.employee = employee
    }
}

// MARK: - SuccessPresenterProtocol

extension SuccessPresenter: SuccessPresenterProtocol {
    func viewDidLoad() {
        sections = makeSections()
        view?.decorate()
    }

    func navigateToEmployeeDetail() {
        router.navigateToEmployeeDetail(employee: employee)
    }
}

// MARK: - SuccessInteractorOutputProtocol

extension SuccessPresenter: SuccessInteractorOutputProtocol {
}

private extension SuccessPresenter {
    func makeSections() -> [CollectionViewSection] {
        let message = "Congratulations you have successfully updated personal details and additional details for \(employee.firstName ?? "") \(employee.lastName ?? "") on \(employee.createAt ?? "")"
        let section = CollectionViewSection(
            title: "",
            items: [
                SuccessViewModel(
                    success: message
                )
            ]
        )

        sections.append(section)
        return sections
    }
}
