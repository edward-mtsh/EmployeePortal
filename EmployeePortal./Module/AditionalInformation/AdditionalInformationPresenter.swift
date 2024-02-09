import Foundation
import UIKit

final class AdditionalInformationPresenter {
    // MARK: - AdditionalInformationPresenterProtocol

    var interactor: AdditionalInformationInteractorInputProtocol?
    var sections: [CollectionViewSection] = []

    // MARK: - Properties

    weak private var view: AdditionalInformationViewProtocol?
    private let router: AdditionalInformationRouterProtocol
    private let employee: EmployeeModel
    private var color: ColorModel?
    private var residentialAddress: String?
    private var gender: String = "Male"

    // MARK: - Lifecycle

    init(interface: AdditionalInformationViewProtocol, 
         interactor: AdditionalInformationInteractorInputProtocol?,
         router: AdditionalInformationRouterProtocol,
         employee: EmployeeModel) {
        self.view = interface
        self.interactor = interactor
        self.router = router
        self.employee = employee
    }
}

// MARK: - AdditionalInformationPresenterProtocol

extension AdditionalInformationPresenter: AdditionalInformationPresenterProtocol {
    func viewDidLoad() {
        sections = makeSections(color: nil)
        view?.decorate()
    }

    func navigateToColorList() {
        router.navigateToColorList(delegate: self)
    }

    func didTabNextButton() {
        let employeeModel = EmployeeModel(
            id: employee.id,
            email: employee.email,
            firstName: employee.firstName,
            lastName: employee.lastName,
            avatar: employee.avatar,
            dateOfBirth: employee.dateOfBirth,
            gender: gender,
            placeOfBirth: employee.placeOfBirth,
            preferredColor: color?.color,
            preferredColorName: color?.name,
            residentialAddress: residentialAddress
        )

        router.navigateToReview(employee: employeeModel)
    }

    func updateResidentialAddress(address: String) {
        residentialAddress = address
    }

    func updateGender(gender: String) {
        self.gender = gender
    }
}

// MARK: - AdditionalInformationInteractorOutputProtocol

extension AdditionalInformationPresenter: AdditionalInformationInteractorOutputProtocol {
}

private extension AdditionalInformationPresenter {
    func makeSections(color: ColorModel?) -> [CollectionViewSection] {
        var hexColor: UIColor = .black

        if let hex = color?.color {
            hexColor = UIColor(hex: hex) ?? .black
        }

        let section = CollectionViewSection(
            title: "",
            items: [
                AdditionalInformationViewModel(
                    color: hexColor,
                    name: color?.name ?? "Color Name"
                )
            ]
        )

        sections.append(section)
        return sections
    }
}

extension AdditionalInformationPresenter: ColorListPresenterDelegate {
    func didSelectColor(color: ColorModel) {
        sections.removeAll()
        self.color = color
        sections = makeSections(color: color)
        view?.decorate()
    }
}
