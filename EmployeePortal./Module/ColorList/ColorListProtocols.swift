import Foundation

// MARK: - View
/// Presenter -> ViewController
protocol ColorListViewProtocol: ViewProtocol {
    var presenter: ColorListPresenterProtocol? { get set }
}

// MARK: - Interactor
/// Presenter -> Interactor
protocol ColorListInteractorInputProtocol: AnyObject {
    var presenter: ColorListInteractorOutputProtocol? { get set }

    func fetchColorList()
}

/// Interactor -> Presenter
protocol ColorListInteractorOutputProtocol: AnyObject {
    func didFetchColors(colors: [ColorModel])
    func onColorListFetchFailure()
}

// MARK: - Presenter
/// ViewController -> Presenter
protocol ColorListPresenterProtocol: AnyObject, ViewControllerLifeCycle {
    var interactor: ColorListInteractorInputProtocol? { get set }
    var colorList: [ColorModel] { get }

    func didSelectColor(at indexPath: IndexPath)
    func makeViewModel(using indexPath: IndexPath) -> ColorListViewModel?
}

// MARK: - Router
/// Navigation
protocol ColorListRouterProtocol: AnyObject {
}
