//
//  ViewController.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import UIKit
import Combine

class RepoListViewController: UIViewController {

    private var viewModel: RepoListViewModel
    private var cancellables = Set<AnyCancellable>()
    let tv = UITableView()

    init(viewModel: RepoListViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupBindings()
    }

    private func configureUI() {
        view.backgroundColor = .white
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor(
            red: 6.0 / 255.0,
            green: 55.0 / 255.0,
            blue: 90.0 / 255.0,
            alpha: 1.0
        )]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes

        navigationController?.navigationBar.prefersLargeTitles = true

        title = "\(viewModel.username)'s repos"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupTableView()
    }

    private func setupTableView() {
        tv.delegate = self
        tv.dataSource = self
        tv.allowsSelection = false
        tv.separatorStyle = .none
        tv.register(RepoTableViewCell.self, forCellReuseIdentifier: String(describing: RepoTableViewCell.self))
        tv.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tv)
        NSLayoutConstraint.activate([
            tv.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tv.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tv.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tv.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func setupBindings() {
        viewModel.$repoList
            .receive(on: RunLoop.main)
            .sink { [weak self] repos in
                guard !repos.isEmpty else {
                    self?.showEmptyState()
                    return
                }
                self?.tv.reloadData()
            }
            .store(in: &cancellables)

        viewModel.$errorMessage
            .receive(on: RunLoop.main)
            .sink { [weak self] errorMessage in
                if let message = errorMessage {
                    self?.presentError(message)
                }
            }
            .store(in: &cancellables)

        viewModel.fetchRepos()
    }

    private func presentError(_ error: String) {
        // Present an alert or some other form of error message to the user
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    private func showEmptyState() {
        // Show an empty state view or message
        let messageLabel = UILabel()
        messageLabel.text = "No repositories found."
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()
        tv.backgroundView = messageLabel
    }
}


extension RepoListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
           return viewModel.sectionTitle
       }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = UIColor(red: 0, green: 106 / 255, blue: 183 / 255, alpha: 1.0)
        let font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        header.textLabel?.font = font
        header.textLabel?.numberOfLines = 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repoList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RepoTableViewCell.self)) as? RepoTableViewCell else { return UITableViewCell() }
        let repo = viewModel.repoList[indexPath.row]
        cell.titleLabel.text = repo.name
        cell.descriptionLabel.text = repo.description

        return cell
    }
}
