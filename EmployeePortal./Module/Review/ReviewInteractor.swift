import Foundation

final class ReviewInteractor {
    // MARK: - ReviewInteractorInputProtocol

    weak var presenter: ReviewInteractorOutputProtocol?

    // MARK: - Properties

    private let service: NetworkKitProtocol

    // MARK: - Properties

    init(service: NetworkKitProtocol) {
        self.service = service
    }
}

// MARK: - ReviewInteractorInputProtocol

extension ReviewInteractor: ReviewInteractorInputProtocol {
    func updateEmployeeInformation(employee: EmployeeModel) {
        let review = ReviewRequest(
            userLoginToken: "QpwL5tke4Pnpja7X4",
            personalDetails: PersonalDetailsModel(
                id: employee.id,
                email: employee.email,
                firstName: employee.firstName,
                lastName: employee.lastName,
                avatar: employee.avatar,
                dateOfBirth: employee.dateOfBirth,
                gender: employee.gender
            ),
            additionalInformation: AdditionalInformationModel(
                placeOfBirth: employee.placeOfBirth,
                preferredColor: employee.preferredColor,
                residentialAddress: employee.residentialAddress
            )
        )

        service.dataTask(for: ReviewRequest.self, route: ReviewRoute.review(review)) { [weak self] result, error in
            if let result = result {
                DispatchQueue.main.async {
                    var employeeModel: EmployeeModel = employee
                    employeeModel.createAt = result.createdAt
                    self?.presenter?.didUpdateEmployees(employee: employeeModel)
                }
            } else {
                DispatchQueue.main.async {
                    self?.presenter?.onUpdateEmployeeFailure()
                }
            }
        }
    }
}
