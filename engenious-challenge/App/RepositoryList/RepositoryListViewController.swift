//
//  RepositoryListViewController.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import UIKit
import Combine

final class RepositoryListViewController: UIViewController {
    enum Constants {
        static let tableViewHeaderText = "Repositories"
        static let retryActionText = "Retry"
        static let okActionText = "OK"
        static let repoCellReuseId = String(describing: RepoTableViewCell.self)
        static let bgColor = AppColor.bgColor
        static let navigationTitleTextColor = AppColor.navigationTitleTextColor
        static let progressColor = AppColor.blueColor
    }
    
    // MARK: - Properties
    private var cancellable = Set<AnyCancellable>()
    private let viewModel: RepositoryListViewModel
    private var cellViewModels: [RepoCellViewModel] = []
    private lazy var navBarShadow: NSShadow = {
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.black.withAlphaComponent(0.3)
        shadow.shadowBlurRadius = 4
        shadow.shadowOffset = CGSize(width: 1, height: 5)
        return shadow
    }()
    
    // MARK: - Subviews
    private let refreshControl = UIRefreshControl()
    private lazy var repoTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        tableView.register(
            RepoTableViewCell.self,
            forCellReuseIdentifier: Constants.repoCellReuseId
        )
        return tableView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.isHidden = true
        return indicator
    }()
    
    // MARK: - Lifecycle
    init(viewModel: RepositoryListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutSubviews()
        setupStyles()
        setupBindings()
        setupRefreshControl()
        
        viewModel.setup()
    }
    
    // MARK: - UI Configurations
    private func layoutSubviews() {
        view.addSubview(
            repoTableView, 
            withConstraints: .zero
        )
        view.addSubview(
            activityIndicator,
            withPosition: .center(width: 60, height: 60)
        )
    }
    
    private func setupStyles() {
        view.backgroundColor = Constants.bgColor
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.applyAttributes([
            NSAttributedString.Key.foregroundColor: Constants.navigationTitleTextColor,
            NSAttributedString.Key.shadow: navBarShadow
        ])
        
        activityIndicator.color = Constants.progressColor
        refreshControl.tintColor = Constants.progressColor
        repoTableView.separatorStyle = .none
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
                    repoTableView.isHidden = false
                    activityIndicator.isHidden = true
                    activityIndicator.stopAnimating()
                    self.cellViewModels = models
                    self.refreshControl.endRefreshing()
                    self.repoTableView.reloadData()
                case .loading:
                    repoTableView.isHidden = true
                    activityIndicator.isHidden = false
                    activityIndicator.startAnimating()
                case .failed(let error):
                    repoTableView.isHidden = false
                    activityIndicator.isHidden = true
                    activityIndicator.stopAnimating()
                    self.repoTableView.reloadData()
                    self.refreshControl.endRefreshing()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.showError(error)
                    }
                default:
                    break
                }
            }
            .store(in: &cancellable)
    }
    
    private func setupRefreshControl() {
        refreshControl.addTarget(
            self,
            action: #selector(refreshData),
            for: .valueChanged
        )
    }
    
    // MARK: - Actions
    @objc private func refreshData() {
        self.viewModel.refresh(refreshControl: true)
    }
}

// MARK: - Alert
fileprivate extension RepositoryListViewController {
    func showError(_ error: ApiError) {
        let alert = UIAlertController(
            title: error.alertTitle,
            message: error.alertMessage,
            preferredStyle: .alert
        )
        let retryAction = UIAlertAction(
            title: Constants.retryActionText,
            style: .default
        ) { _ in
            self.viewModel.refresh(refreshControl: false)
        }
        let okAction = UIAlertAction(title: Constants.okActionText, style: .cancel, handler: nil)
        alert.addAction(retryAction)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
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
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.repoCellReuseId
        ) as? RepoTableViewCell else {
            return UITableViewCell()
        }
        let vm = cellViewModels[indexPath.row]
        cell.configure(with: vm)
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        let view = RepoHeaderView()
        view.setup(with: Constants.tableViewHeaderText)
        return view
    }
}
