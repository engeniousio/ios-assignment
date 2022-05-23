import UIKit
import Combine

// MARK: - RootViewController

final class RootViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: RootViewModelProtocol!
    
    // MARK: - View
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    init(viewModel: RootViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        title = viewModel.displayUsername
        navigationController?.navigationBar.prefersLargeTitles = true

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RepoTableViewCell.self, forCellReuseIdentifier: String(describing: RepoTableViewCell.self))
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        setupNavigationBar()
        
        getRepos()
    }

    // MARK: - Methods
    
    func getRepos() {
        viewModel.getRepos { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func setupNavigationBar() {
        let attributes = [
            NSAttributedString.Key.foregroundColor : UIColor(0x06375A),
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 24, weight: .bold)
        ]
        
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
        navigationController?.navigationBar.titleTextAttributes = attributes
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension RootViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.repoList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RepoTableViewCell.self)) as? RepoTableViewCell else { return UITableViewCell() }
        cell.config(with: viewModel.repoList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        RepoSectionHeaderView()
    }
}
