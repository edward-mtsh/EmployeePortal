import Foundation

// MARK: - View
/// Presenter -> ViewController
protocol AdditionalInformationViewProtocol: ViewProtocol {
    var presenter: AdditionalInformationPresenterProtocol? { get set }
}

// MARK: - Interactor
/// Presenter -> Interactor
protocol AdditionalInformationInteractorInputProtocol: AnyObject {
    var presenter: AdditionalInformationInteractorOutputProtocol? { get set }
}

/// Interactor -> Presenter
protocol AdditionalInformationInteractorOutputProtocol: AnyObject {
}

// MARK: - Presenter
/// ViewController -> Presenter
protocol AdditionalInformationPresenterProtocol: AnyObject, ViewControllerLifeCycle {
    var interactor: AdditionalInformationInteractorInputProtocol? { get set }
    var sections: [CollectionViewSection] { get }

    func navigateToColorList() 
    func didTabNextButton()
    func updateResidentialAddress(address: String)
    func updateGender(gender: String)
}

// MARK: - Router
/// Navigation
protocol AdditionalInformationRouterProtocol: AnyObject {
    func navigateToColorList(delegate: ColorListPresenterDelegate?)
    func navigateToReview(employee: EmployeeModel)
}
