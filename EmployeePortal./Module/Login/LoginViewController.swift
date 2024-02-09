import UIKit

final class LoginViewController: UIViewController {
    @IBOutlet weak var profileLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var profileLable: UIStackView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!

    // MARK: - LoginViewProtocol

    var presenter: LoginPresenterProtocol?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    @IBAction func loginAction(_ sender: Any) {
        guard let username = usernameTextField.text, let password = passwordTextField.text else { return }

        presenter?.validate(username: username, password: password)
    }
}

// MARK: - LoginViewProtocol

extension LoginViewController: LoginViewProtocol {
    func decorate() { }

    func showLoader() {
        showBusyView()
    }

    func hideLoader() {
        hideBusyView()
    }
}

private extension LoginViewController {
    func configureView() {
        scrollView.keyboardDismissMode = .onDrag
        usernameTextField.makeBorder()
        passwordTextField.makeBorder()
        loginButton.makeBorder()
    }
}
