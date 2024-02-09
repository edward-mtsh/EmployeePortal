import UIKit

final public class LoginModule {
    public static func build() -> UIViewController {
        let view = LoginViewController()
        let router = LoginRouter()
        let interactor = LoginInteractor(service: NetworkKit())
        let presenter = LoginPresenter(
            interface: view,
            interactor: interactor,
            router: router,
            emailAddressValidator: EmailAddressValidator()
        )

        view.presenter = presenter
        router.viewController = view
        interactor.presenter = presenter

        return view
    }
}
