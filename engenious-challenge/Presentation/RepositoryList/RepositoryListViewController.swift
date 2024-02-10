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
    private var cellViewModels: [RepoCellViewModel] = []
    
    // MARK: - Subviews
    private lazy var repoTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
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
        
        viewModel.$listState
            .sink { [weak self] state in
                guard let self else { return }
                switch state {
                case .loaded(let models):
                    self.cellViewModels = models
                    self.repoTableView.reloadData()
                case .loading:
                    print("TODO: add loading")
                case .failed:
                    print("TODO: show error")
                    self.cellViewModels = []
                    self.repoTableView.reloadData()
                default:
                    break
                }
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
        cellViewModels.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RepoTableViewCell.self)) as? RepoTableViewCell else { return UITableViewCell() }
        let vm = cellViewModels[indexPath.row]
        cell.configure(with: vm)
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        let view = RepoHeaderView()
        view.setup(with: "Repositories")
        return view
    }
}
