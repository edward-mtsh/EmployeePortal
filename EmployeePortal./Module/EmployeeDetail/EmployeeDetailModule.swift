import UIKit

final class EmployeeDetailModule {
    public static func build(employee: EmployeeModel?) -> UIViewController {
        let view = EmployeeDetailViewController()
        view.navigationItem.hidesBackButton = true
        let router = EmployeeDetailRouter()
        let interactor = EmployeeDetailInteractor()
        let presenter = EmployeeDetailPresenter(
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
