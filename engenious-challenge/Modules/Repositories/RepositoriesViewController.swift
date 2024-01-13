//
//  ViewController.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import UIKit
import Combine

class RepositoriesViewController: BaseController<RepositoriesViewModel>, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let username: String = "Apple"
    private var cellViewModels: [RepositoryCellViewModel] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupTableView()
        self.viewModel.getRepositories()
    }
    
    // MARK: - Binding
    override func bind(viewModel: RepositoriesViewModel) {
        viewModel.$repositories
            .sink { [weak self] repositories in
                self?.cellViewModels = repositories.map { RepositoryCellViewModel(repository: $0) }
                self?.tableView.reloadData()
            }
            .store(in: &cancellable)
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.view.backgroundColor = .white
        self.title = "\(username)'s Repos"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: - Table View Setup
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: RepositoryTableViewCell.identifier)
        
        let headerView = createTableHeaderView()
        tableView.tableHeaderView = headerView
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // MARK: - Header View Creation
    private func createTableHeaderView() -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        
        let headerLabel: UILabel = {
            let label = UILabel()
            label.textColor = .listTitleColor
            label.text = "Repositories"
            label.textAlignment = .left
            label.font = .systemFont(ofSize: 20, weight: .semibold)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        headerView.addSubview(headerLabel)
        
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            headerLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 40)
        ])
        
        return headerView
    }

    // MARK: - Table View DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryTableViewCell.identifier, for: indexPath) as? RepositoryTableViewCell else {
            return UITableViewCell()
        }
        let viewModel = cellViewModels[indexPath.row]
        cell.configure(with: viewModel)
        return cell
    }
}
