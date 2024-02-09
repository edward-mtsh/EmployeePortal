import UIKit

final class EmployeeListViewController: UIViewController {

    // MARK: - EmployeeListViewProtocol

    var presenter: EmployeeListPresenterProtocol?
    private var tableView: UITableView?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = .title
        view.backgroundColor = .white
        setupTableView()
        presenter?.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
    }
}

// MARK: - EmployeeListViewProtocol

extension EmployeeListViewController: EmployeeListViewProtocol {
    func decorate() {
        tableView?.reloadData()
    }

    func showLoader() {
        showBusyView()
    }

    func hideLoader() {
        hideBusyView()
    }

    func dismissView() {
        dismiss(animated: true)
    }
}

private extension EmployeeListViewController {
    func setupTableView() {
        tableView = UITableView()
        tableView?.translatesAutoresizingMaskIntoConstraints = false
        tableView?.isScrollEnabled = true
        tableView?.backgroundColor = .white
        tableView?.delegate = self
        tableView?.dataSource = self

        guard let tableView else { return }

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])

        registerCells()
    }

    func registerCells() {
        guard let tableView else { return }

        let nib = UINib(nibName: EmployeeTableViewCell.defaultReuseIdentifier, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: EmployeeTableViewCell.defaultReuseIdentifier)
    }
}

// MARK: - UITableViewDelegate

extension EmployeeListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.employeeList.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeTableViewCell.defaultReuseIdentifier) as? EmployeeTableViewCell

        if let viewModel = presenter?.makeViewModel(using: indexPath) {
            cell?.decorate(using: viewModel)
        }

        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {       
        presenter?.didSelectEmployee(at: indexPath)
    }
}

private extension String {
    static let title = "List of Employees"
}
