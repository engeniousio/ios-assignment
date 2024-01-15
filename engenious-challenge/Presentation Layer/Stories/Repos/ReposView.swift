//
//  ViewController.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import UIKit
import Combine

class ReposView: BaseScreen {
    
    // MARK: - Constants

    private enum Constants {
        static let title = "Jon Doe"
        static let tableViewTitle = "Repositories"
        static let tableViewHeaderHeights: CGFloat = 40
    }
    
    // MARK: - Properties(private)
    
    private var repoList: [Repo] = []
    private let tableView = UITableView()
    
    // MARK: - Subscribers

    private var repoListSubscriber: AnyCancellable?
    
    // MARK: - Properties(public)
    
    var viewModel: ReposViewModelProtocol?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTableView()
        bindOnViewModel()
    }

    // MARK: - Methods(private)
    
    private func setupView() {
        view.backgroundColor = .white
        title = Constants.title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.headerColor ?? .black]
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(RepoTableViewCell.self, forCellReuseIdentifier: String(describing: RepoTableViewCell.self))
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func bindOnViewModel() {
        repoListSubscriber = viewModel?.selectedCategoryPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] value in
                self?.afterViewLoaded {
                    DispatchQueue.main.async {
                        self?.repoList = value
                        self?.tableView.reloadData()
                    }
                }
            })
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ReposView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repoList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RepoTableViewCell.self)) as? RepoTableViewCell else { return UITableViewCell() }
        let repo = repoList[indexPath.row]
        cell.titleLabel.text = repo.name
        cell.descriptionLabel.text = repo.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = TableViewHeader(frame: .zero)
        view.titleLabel.text = Constants.tableViewTitle
        view.backgroundColor = .white
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        Constants.tableViewHeaderHeights
    }
}
