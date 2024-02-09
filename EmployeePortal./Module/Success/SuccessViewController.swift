import UIKit

final class SuccessViewController: UIViewController {
    private typealias DataSource = UICollectionViewDiffableDataSource<CollectionViewSection, AnyHashable>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<CollectionViewSection, AnyHashable>

    private var dataSource: DataSource?
    private var collectionView: UICollectionView?
    private lazy var doneButton = UIButton()

    // MARK: - SuccessViewProtocol

    var presenter: SuccessPresenterProtocol?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCollectionView()
        setupDoneButton()
        presenter?.viewDidLoad()
    }
}

// MARK: - SuccessViewProtocol

extension SuccessViewController: SuccessViewProtocol {
    func decorate() {
        removeAllItemsFromCollectionView()
        applySnapshot()
    }
}

private extension SuccessViewController {
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
        ])

        registerCells()
        createDataSource()
    }

    func setupDoneButton() {
        doneButton.setTitle(.buttonTitle, for: .normal)
        doneButton.setTitleColor(.black, for: .normal)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        doneButton.makeBorder(cornerRadius: 1)

        view.addSubview(doneButton)

        guard let collectionView else { return }

        NSLayoutConstraint.activate([
            doneButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16),
            doneButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            doneButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -260),
            doneButton.heightAnchor.constraint(equalToConstant: 40)
        ])
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
                if let viewModel = item as? SuccessViewModel {
                    return self?.makeSuccess(for: collectionView, at: indexPath, using: viewModel)
                } else {
                    return nil
                }
            }
        )
    }

    func registerCells() {
        guard let collectionView else { return }

        let nib = UINib(nibName: SucessCollectionViewCell.defaultReuseIdentifier ,bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: SucessCollectionViewCell.defaultReuseIdentifier)
    }

    func makeSuccess(for collectionView: UICollectionView,
                     at indexPath: IndexPath,
                     using viewModel: SuccessViewModel) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SucessCollectionViewCell.defaultReuseIdentifier,
            for: indexPath
        ) as? SucessCollectionViewCell
        cell?.decorate(using: viewModel)
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

    @objc func doneButtonTapped() {
        presenter?.navigateToEmployeeDetail()
    }
}

private extension String {
    static let buttonTitle = "Done"
}
