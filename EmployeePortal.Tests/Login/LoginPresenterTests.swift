@testable import EmployeePortal_
import XCTest

class LoginPresenterTests: XCTestCase {
    // MARK: - Properties

    var presenter: LoginPresenter!
    var view: MockLoginViewController!
    var interactor: MockLoginInteractor!
    var router: MockLoginRouter!

    // MARK: - Lifecycle

    override func setUp() {
        makePresenter()
    }

    // MARK: - Test Methods

    func testLoginWithCorrectDetailsThenNavigateToEmployeeDetailIsCalled() {
        presenter.validate(username: "eddie@gmail.com", password: "fhdjfhdjfhdfjhfd")

        XCTAssertTrue(view.showLoaderCalled)
        XCTAssertTrue(view.hideLoaderCalled)
        XCTAssertTrue(router.navigateToEmployeeDetailCalled)
    }

    func testLoginWithInCorrectEmailThenShowErrorIsCalled() {
        presenter.validate(username: "eddie", password: "fhdjfhdjfhdfjhfd")

        XCTAssertFalse(view.showLoaderCalled)
        XCTAssertFalse(view.hideLoaderCalled)
        XCTAssertTrue(router.showErrorCalled)
    }

    func testLoginWithInCorrectPasswordLimitThenShowErrorIsCalled() {
        presenter.validate(username: "eddie@gmail.com", password: "fhdjfh")

        XCTAssertFalse(view.showLoaderCalled)
        XCTAssertFalse(view.hideLoaderCalled)
        XCTAssertTrue(router.showErrorCalled)
    }

    func testLoginFailureThenThenShowErrorIsCalled() {
        makePresenter(serviceHasError: true)

        presenter.validate(username: "eddie@gmail.com", password: "fhdjfhgfgfg")

        XCTAssertTrue(view.showLoaderCalled)
        XCTAssertTrue(view.hideLoaderCalled)
        XCTAssertTrue(router.showErrorCalled)
    }
}

private extension LoginPresenterTests {
    func makePresenter(serviceHasError: Bool = false) {
        view = MockLoginViewController()
        interactor = MockLoginInteractor(service: MockNetworkKit(hasError: serviceHasError))
        router = MockLoginRouter()
        presenter = LoginPresenter(
            interface: view,
            interactor: interactor,
            router: router,
            emailAddressValidator: MockEmailAddressValidator()
        )
        interactor.presenter = presenter
    }
}
