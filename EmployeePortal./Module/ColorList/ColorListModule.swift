import UIKit

final class ColorListModule {
    public static func build(delegate: ColorListPresenterDelegate?) -> UIViewController {
        let view = ColorListViewController()
        let router = ColorListRouter()
        let interactor = ColorListInteractor(service: NetworkKit())
        let presenter = ColorListPresenter(
            interface: view,
            interactor: interactor,
            router: router,
            delegate: delegate
        )

        view.presenter = presenter
        router.viewController = view
        interactor.presenter = presenter

        return view
    }
}
