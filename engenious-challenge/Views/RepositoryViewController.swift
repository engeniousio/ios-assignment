//
//  ViewController.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import UIKit
import Combine

final class RepositoryViewController: UIViewController, ControlSetup {
    private enum Consts {
        static let username = "Apple"
        static let headerViewHeight: CGFloat = 50
    }
    private let viewModel: RepositoryViewModelProtocol?
    private let tableView = UITableView()
    
    private lazy var headerView: RepositoryHeaderView = {
        let headerView = RepositoryHeaderView(frame: .zero, style: RepositoryHeaderStyle())
        headerView.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: Consts.headerViewHeight)
        return headerView
    }()
    
    init(viewModel: RepositoryViewModelProtocol?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: String(describing: RepositoryTableViewCell.self))
        controlSetup()
        setupDelegates()
        setupNavigation()
        createHeaderView()
        getRepo()
    }
    
    func setupSubviews() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
    }
    
    func setupAutoLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupStyle() {
        view.backgroundColor = .white
        title = Consts.username
        tableView.separatorStyle = .none
    }
    
    private func getRepo() {
        viewModel?.getRepos(username: Consts.username, reloadCompletion: { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
    }
    
    private func setupNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func createHeaderView() {
        tableView.tableHeaderView = headerView
    }
}

// MARK: Extensions

extension RepositoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.repoList.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RepositoryTableViewCell.self), for: indexPath) as? RepositoryTableViewCell else {
            return UITableViewCell()
        }

        if let repo = viewModel?.repoList[indexPath.row] {
            cell.configure(cellViewModel: repo)
        }

        return cell
    }
}

