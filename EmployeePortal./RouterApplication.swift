import Foundation
import UIKit

class RouterApplication {
    static let shared = RouterApplication()

    func navigateToLogin(navigationController: UINavigationController?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        if let view = storyboard.instantiateViewController(withIdentifier: "loginViewController") as? LoginViewController {
            view.navigationItem.hidesBackButton = true
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

            navigationController?.pushViewController(view, animated: false)
        }
    }
}
