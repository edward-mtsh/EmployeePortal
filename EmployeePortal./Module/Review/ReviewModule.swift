import UIKit

final class ReviewModule {
    static func build(employee: EmployeeModel) -> UIViewController {
        let view = ReviewViewController()
        let router = ReviewRouter()
        let interactor = ReviewInteractor(service: NetworkKit())
        let presenter = ReviewPresenter(
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
