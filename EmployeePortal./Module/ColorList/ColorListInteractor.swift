import Foundation

final class ColorListInteractor {
    // MARK: - ColorListInteractorInputProtocol
    
    weak var presenter: ColorListInteractorOutputProtocol?
    
    // MARK: - Properties

    private let service: NetworkKitProtocol

    // MARK: - Properties

    init(service: NetworkKitProtocol) {
        self.service = service
    }
}

// MARK: - ColorListInteractorInputProtocol

extension ColorListInteractor: ColorListInteractorInputProtocol {
    func fetchColorList() {
        service.dataTask(for: ColorListResponse.self, route: ColorListRoute.path){ [weak self] result, error in
            if let colors = result?.data {
                DispatchQueue.main.async {
                    self?.presenter?.didFetchColors(colors: colors)
                }
            } else {
                DispatchQueue.main.async {
                    self?.presenter?.onColorListFetchFailure()
                }
            }
        }
    }
}

