//
//  ViewController.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import UIKit
import Combine

class RepositoriesViewController: BaseController<RepositoriesViewModel>,
                                  UITableViewDelegate,
                                  UITableViewDataSource {
    
    
    // MARK: - SubViews
    private let tableView = UITableView()
    private let username: String = "Apple"
    private var repoList: [RepositoryResponse] = []
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "\(username)'s repos"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.setupTableView()
        self.viewModel.getRepositories()
    }
    
    // MARK: - Binding
    override func bind(viewModel: RepositoriesViewModel) {
        viewModel.$repositories
                .sink { [weak self] repositories in
                    self?.repoList = repositories
                    self?.tableView.reloadData()
                }
                .store(in: &cancellable)
    }
    
    // MARK: - Methods
    private func createTableHeaderView() -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100)) // Adjust the height as needed
        let headerLabel = UILabel()
        headerLabel.textColor = .listTitleColor
        headerLabel.text = "Repositories"
        headerLabel.textAlignment = .left
        headerLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(headerLabel)
        
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            headerLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 40)
        ])
        
        return headerView
    }
    
    private func setupTableView() {
        let headerView = createTableHeaderView()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: String(describing: RepositoryTableViewCell.self))
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(tableView)
        self.tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.tableView.separatorStyle = .none
        self.tableView.tableHeaderView = headerView
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RepositoryTableViewCell.self)) as? RepositoryTableViewCell else { return UITableViewCell() }
        let repo = repoList[indexPath.row]
        cell.titleLabel.text = repo.name
        cell.captionLabel.text = repo.description
        return cell
    }
}

