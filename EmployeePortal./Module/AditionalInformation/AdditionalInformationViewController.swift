import UIKit

final class AdditionalInformationViewController: UIViewController {
    private typealias DataSource = UICollectionViewDiffableDataSource<CollectionViewSection, AnyHashable>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<CollectionViewSection, AnyHashable>

    private var dataSource: DataSource?
    private var collectionView: UICollectionView?

    // MARK: - AdditionalInformationViewProtocol

    var presenter: AdditionalInformationPresenterProtocol?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = .title
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        addRightNavigationBarButton()
        setupCollectionView()
        presenter?.viewDidLoad()
    }
}

// MARK: - AdditionalInformationViewProtocol

extension AdditionalInformationViewController: AdditionalInformationViewProtocol {
    func decorate() {
        removeAllItemsFromCollectionView()
        applySnapshot()
    }
}

private extension AdditionalInformationViewController {
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
                if let viewModel = item as? AdditionalInformationViewModel {
                    return self?.makeAdditionalInformation(for: collectionView, at: indexPath, using: viewModel)
                } else {
                    return nil
                }
            }
        )
    }

    func registerCells() {
        guard let collectionView else { return }

        let nib = UINib(nibName: AdditionalInformationCollectionViewCell.defaultReuseIdentifier ,bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: AdditionalInformationCollectionViewCell.defaultReuseIdentifier)
    }

    func makeAdditionalInformation(for collectionView: UICollectionView,
                                   at indexPath: IndexPath,
                                   using viewModel: AdditionalInformationViewModel) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AdditionalInformationCollectionViewCell.defaultReuseIdentifier,
            for: indexPath
        ) as? AdditionalInformationCollectionViewCell
        cell?.decorate(using: viewModel)
        cell?.actionHandler = {
            self.presenter?.navigateToColorList()
        }
        cell?.editingChangedHandler = { address in
            self.presenter?.updateResidentialAddress(address: address)
        }
        cell?.valueChangedHandler = { gender in
            self.presenter?.updateGender(gender: gender)
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

private extension AdditionalInformationViewController {
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
        presenter?.didTabNextButton()
    }
}

private extension String {
    static let title = "Additional Info"
    static let rightNavigationBarButton = "Next"
}
