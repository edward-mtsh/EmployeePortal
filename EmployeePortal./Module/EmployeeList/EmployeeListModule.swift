import UIKit

final class EmployeeListModule {
    static func build(delegate: EmployeeListPresenterDelegate?) -> UIViewController {
        let view = EmployeeListViewController()
        let router = EmployeeListRouter()
        let interactor = EmployeeListInteractor(service: NetworkKit())
        let presenter = EmployeeListPresenter(interface: view, interactor: interactor, router: router)
        presenter.delegate = delegate

        view.presenter = presenter
        router.viewController = view
        interactor.presenter = presenter

        return view
    }
}
