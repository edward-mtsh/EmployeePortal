import UIKit

final class EmployeeDetailViewController: UIViewController {

    // MARK: - EmployeeDetailViewProtocol

    private typealias DataSource = UICollectionViewDiffableDataSource<CollectionViewSection, AnyHashable>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<CollectionViewSection, AnyHashable>

    private var dataSource: DataSource?
    private var collectionView: UICollectionView?

    var presenter: EmployeeDetailPresenterProtocol?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = .title
        view.backgroundColor = .white
        setupCollectionView()
        presenter?.viewDidLoad()
    }
}

// MARK: - EmployeeDetailViewProtocol

extension EmployeeDetailViewController: EmployeeDetailViewProtocol {
    func decorate() {
        removeAllItemsFromCollectionView()
        applySnapshot()
    }

    func addRightNavigationBarButton() {
        let item = UIBarButtonItem(
            title: .rightNavigationBarButton,
            style: .plain,
            target: self,
            action: #selector(nextButtonTapped)
        )
        item.tintColor = .black
        navigationItem.rightBarButtonItem = item
    }

    @objc
    func nextButtonTapped() {
        presenter?.navigateToAdditionalInformation()
    }
}

private extension EmployeeDetailViewController {
    func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.isScrollEnabled = true
        collectionView?.backgroundColor = .white
        collectionView?.keyboardDismissMode = .onDrag

        guard let collectionView else { return }

        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])

        registerCells()
        createDataSource()
    }

    func createCollectionViewLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { (_ : Int, _: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            return .genericSection
        }
    }

    func createDataSource() {
        guard let collectionView else { return }

        dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { [weak self] collectionView, indexPath, item -> UICollectionViewCell? in
                if let viewModel = item as? EmployeeDetailViewModel {
                    return self?.makeEmployee(for: collectionView, at: indexPath, using: viewModel)
                } else {
                    return nil
                }
            }
        )
    }

    func registerCells() {
        guard let collectionView else { return }

        let nib = UINib(nibName: EmployeeCollectionViewCell.defaultReuseIdentifier ,bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: EmployeeCollectionViewCell.defaultReuseIdentifier)
    }

    func makeEmployee(for collectionView: UICollectionView,
                      at indexPath: IndexPath,
                      using viewModel: EmployeeDetailViewModel) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: EmployeeCollectionViewCell.defaultReuseIdentifier,
            for: indexPath
        ) as? EmployeeCollectionViewCell
        cell?.decorate(using: viewModel)
        cell?.actionHandler = {
            self.presenter?.navigateToEmployeeList()
        }
        cell?.editingChangedHandler = { place in
            self.presenter?.updatePlaceOfBirth(placeOfBirth: place)
        }
        cell?.dateChangedHandler = { date in
            self.presenter?.updateDateOfBirth(dateOfBirth: date)
        }
        return cell ?? UICollectionViewCell()
    }

    func applySnapshot(animatingDifferences: Bool = true) {
        guard let sections = presenter?.sections else { return }

        var snapshot = dataSource?.snapshot() ?? Snapshot()
        snapshot.appendSections(sections)

        sections.forEach { section in
            snapshot.appendItems(section.items, toSection: section)
        }

        dataSource?.apply(snapshot, animatingDifferences: animatingDifferences)
    }

    func removeAllItemsFromCollectionView() {
        guard var snapshot = dataSource?.snapshot() else { return }

        snapshot.deleteAllItems()
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
}

private extension String {
    static let title = "Employee"
    static let rightNavigationBarButton = "Next"
}
