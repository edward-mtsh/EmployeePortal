import Foundation

final class ReviewPresenter {
    // MARK: - ReviewPresenterProtocol
    
    var interactor: ReviewInteractorInputProtocol?
    var sections: [CollectionViewSection] = []

    // MARK: - Properties

    weak private var view: ReviewViewProtocol?
    private let router: ReviewRouterProtocol
    private let employee: EmployeeModel

    // MARK: - Lifecycle

    init(interface: ReviewViewProtocol, 
         interactor: ReviewInteractorInputProtocol?,
         router: ReviewRouterProtocol,
         employee: EmployeeModel) {
        self.view = interface
        self.interactor = interactor
        self.router = router
        self.employee = employee
    }
}

// MARK: - ReviewPresenterProtocol

extension ReviewPresenter: ReviewPresenterProtocol {
    func viewDidLoad() {
        sections = makeSections()
        view?.decorate()
    }

    func didTabSubmitButton() {
        view?.showLoader()
        interactor?.updateEmployeeInformation(employee: employee)
    }
}

// MARK: - ReviewInteractorOutputProtocol

extension ReviewPresenter: ReviewInteractorOutputProtocol {
    func didUpdateEmployees(employee: EmployeeModel) {
        view?.hideLoader()
        router.navigateToSuccessScreen(employee: employee)
    }
    
    func onUpdateEmployeeFailure() {
        view?.hideLoader()
    }
}

private extension ReviewPresenter {
    func makeSections() -> [CollectionViewSection] {
        let section = CollectionViewSection(
            title: "",
            items: [
                ReviewViewModel(
                    email: employee.email ?? "",
                    fullname: "\(employee.firstName ?? "") \(employee.lastName ?? "")",
                    avatar: URL(string: employee.avatar ?? ""),
                    dateOfBirth: employee.dateOfBirth,
                    gender: employee.gender,
                    placeOfBirth: employee.placeOfBirth,
                    preferredColor: employee.preferredColorName,
                    residentialAddress: employee.residentialAddress
                )
            ]
        )

        sections.append(section)
        return sections
    }
}
