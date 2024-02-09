import UIKit

final class ReviewViewController: UIViewController {
    private typealias DataSource = UICollectionViewDiffableDataSource<CollectionViewSection, AnyHashable>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<CollectionViewSection, AnyHashable>

    private var dataSource: DataSource?
    private var collectionView: UICollectionView?
    private lazy var submitButton = UIButton()

    // MARK: - ReviewViewProtocol

    var presenter: ReviewPresenterProtocol?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = .title
        view.backgroundColor = .white
        setupCollectionView()
        setupSubmitButton()
        presenter?.viewDidLoad()
    }
}

// MARK: - ReviewViewProtocol

extension ReviewViewController: ReviewViewProtocol {
    func decorate() {
        removeAllItemsFromCollectionView()
        applySnapshot()
    }

    func showLoader() {
        showBusyView()
    }

    func hideLoader() {
        hideBusyView()
    }
}

private extension ReviewViewController {
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

    func setupSubmitButton() {
        submitButton.setTitle(.buttonTitle, for: .normal)
        submitButton.setTitleColor(.black, for: .normal)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        submitButton.makeBorder(cornerRadius: 1)

        view.addSubview(submitButton)

        guard let collectionView else { return }

        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16),
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            submitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -260),
            submitButton.heightAnchor.constraint(equalToConstant: 40)
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
                if let viewModel = item as? ReviewViewModel {
                    return self?.makeReview(for: collectionView, at: indexPath, using: viewModel)
                } else {
                    return nil
                }
            }
        )
    }

    func registerCells() {
        guard let collectionView else { return }

        let nib = UINib(nibName: ReviewCollectionViewCell.defaultReuseIdentifier ,bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: ReviewCollectionViewCell.defaultReuseIdentifier)
    }

    func makeReview(for collectionView: UICollectionView,
                    at indexPath: IndexPath,
                    using viewModel: ReviewViewModel) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ReviewCollectionViewCell.defaultReuseIdentifier,
            for: indexPath
        ) as? ReviewCollectionViewCell
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

    @objc func submitButtonTapped() {
        presenter?.didTabSubmitButton()
    }
}

private extension String {
    static let title = "Review"
    static let buttonTitle = "Submit"
}

