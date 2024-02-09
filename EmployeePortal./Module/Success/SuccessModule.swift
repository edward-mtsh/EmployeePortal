import UIKit

final class SuccessModule {
    static func build(employee: EmployeeModel) -> UIViewController {
        let view = SuccessViewController()
        let router = SuccessRouter()
        let interactor = SuccessInteractor()
        let presenter = SuccessPresenter(
            interface: view, 
            interactor: interactor,
            router: router,
            employee: employee
        )

        view.presenter = presenter
        router.viewController = view
        interactor.presenter = presenter

        return view
    }
}
