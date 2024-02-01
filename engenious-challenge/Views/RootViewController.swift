//
//  ViewController.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import UIKit
import Combine

final class RootViewController: UIViewController {

    private let username = "Apple"
    private var viewModel: RootViewModel!

    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear // Set your desired background color if needed
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Repositories"
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textAlignment = .left
        label.textColor = UIColor(red: 45, green: 105, blue: 177, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RepoTableViewCell.self, forCellReuseIdentifier: String(describing: RepoTableViewCell.self))
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel = RootViewModel()
#if DEBUG
        getReposCombine()
#else
        getRepos()
#endif
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupHeaderView()
    }

    private func setupHeaderView() {
        headerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 44)
        titleLabel.frame = headerView.bounds
        headerView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
        ])

        tableView.tableHeaderView = headerView
    }

    private func setupUI() {
        view.backgroundColor = .white
        title = "\(username)'s Repos"
        navigationController?.navigationBar.prefersLargeTitles = true

        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func getRepos() {
        viewModel.fetchRepos(for: username) { [weak self] in
            guard let strongSelf = self else { return }

            if let error = strongSelf.viewModel.error {
                // Handle the error here, you can provide custom error handling
                print("Error fetching repos: \(error)")
                // You may want to show an alert to the user or perform other error-specific actions
            } else {
                DispatchQueue.main.async {
                    strongSelf.tableView.reloadData()
                }
            }
        }
    }

    private func getReposCombine() {
        viewModel.fetchReposCombine(for: username) { [weak self] result in
            guard let strongSelf = self else { return }
            
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    strongSelf.tableView.reloadData()
                }
            case .failure(let error):
                // Handle the error here, you can provide custom error handling
                print("Error fetching repos: \(error)")
                // You may want to show an alert to the user or perform other error-specific actions
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension RootViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRepos
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: RepoTableViewCell.self),
            for: indexPath
        ) as? RepoTableViewCell else {
            return UITableViewCell()
        }

        let repo = viewModel.repo(at: indexPath.row)
        cell.titleLabel.text = repo.name
        cell.descriptionLabel.text = repo.description ?? "No description available" // Display the description
        return cell
    }
}

// MARK: - UITableViewDelegate

extension RootViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120 // Adjust the value based on your preference
    }
}



