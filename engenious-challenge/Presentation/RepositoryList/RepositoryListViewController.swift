//
//  RepositoryListViewController.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import UIKit
import Combine

final class RepositoryListViewController: UIViewController {
    
    // MARK: - Properties
    private var cancellable = Set<AnyCancellable>()
    private let viewModel: RepositoryListViewModel
    
    // MARK: - Subviews
    private lazy var repoTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    // MARK: - Lifecycle
    init(viewModel: RepositoryListViewModel = .init()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        repoTableView.register(
            RepoTableViewCell.self,
            forCellReuseIdentifier: String(describing: RepoTableViewCell.self)
        )
        layoutSubviews()
        setupBindings()
        
        viewModel.setup()
    }
    
    private func layoutSubviews() {
        view.addSubview(repoTableView, withConstraints: .zero)
    }
    
    private func setupBindings() {
        viewModel.$navigationTitle
            .sink { [weak self] in
                self?.title = $0
            }
            .store(in: &cancellable)
        
        viewModel.$repoList
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.repoTableView.reloadData()
            }
            .store(in: &cancellable)
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension RepositoryListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return viewModel.repoList.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RepoTableViewCell.self)) as? RepoTableViewCell else { return UITableViewCell() }
        let repo = viewModel.repoList[indexPath.row]
        cell.titleLabel.text = repo.name
        return cell
    }
}
