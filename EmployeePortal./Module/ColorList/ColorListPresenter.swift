import Foundation
import UIKit

protocol ColorListPresenterDelegate: AnyObject {
    func didSelectColor(color: ColorModel)
}

final class ColorListPresenter {
    // MARK: - ColorListPresenterProtocol
    
    var interactor: ColorListInteractorInputProtocol?
    var colorList: [ColorModel] = []
    weak var delegate: ColorListPresenterDelegate?
    
    // MARK: - Properties
    
    weak private var view: ColorListViewProtocol?
    private let router: ColorListRouterProtocol
    
    // MARK: - Lifecycle

    init(interface: ColorListViewProtocol, 
         interactor: ColorListInteractorInputProtocol?,
         router: ColorListRouterProtocol,
         delegate: ColorListPresenterDelegate?) {
        self.view = interface
        self.interactor = interactor
        self.router = router
        self.delegate = delegate
    }
}

// MARK: - ColorListPresenterProtocol

extension ColorListPresenter: ColorListPresenterProtocol {
    func viewDidLoad() {
        view?.showLoader()
        interactor?.fetchColorList()
    }

    func didSelectColor(at indexPath: IndexPath) {
        if let color = colorList.element(at: indexPath.row), let name = color.name, let hex = color.color {
            delegate?.didSelectColor(color: ColorModel(name: name, color: hex))
            view?.dismissView()
        }
    }

    func makeViewModel(using indexPath: IndexPath) -> ColorListViewModel? {
        if let color = colorList.element(at: indexPath.row) {
            guard let name = color.name,
                  let hex = color.color else { return nil }

            return ColorListViewModel(
                color: UIColor(hex: hex),
                name: name
            )
        }

        return nil
    }
}

// MARK: - ColorListInteractorOutputProtocol

extension ColorListPresenter: ColorListInteractorOutputProtocol {
    func didFetchColors(colors: [ColorModel]) {
        view?.hideLoader()

        colors.forEach { color in
            colorList.append(
                ColorModel(
                    id: color.id,
                    name: color.name,
                    year: color.year,
                    color: color.color,
                    pantoneValue: color.pantoneValue
                )
            )
        }

        view?.decorate()
    }
    
    func onColorListFetchFailure() {
        view?.hideLoader()
    }
}
