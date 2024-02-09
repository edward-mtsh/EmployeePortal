import UIKit

final class AdditionalInformationModule {
    public static func build(employee: EmployeeModel) -> UIViewController {
        let view = AdditionalInformationViewController()
        let router = AdditionalInformationRouter()
        let interactor = AdditionalInformationInteractor()
        let presenter = AdditionalInformationPresenter(
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
