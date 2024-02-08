//
//  ResposListViewController.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import UIKit
import Combine

class ResposListViewController: UIViewController {

    private var viewModel: ResposListViewModel
    
    private let tv = UITableView()

    init(viewModel: ResposListViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBinding()
        
        view.backgroundColor = .white

        navigationController?.navigationBar.prefersLargeTitles = true

        tv.delegate = self
        tv.dataSource = self
        tv.register(RepoTableViewCell.self, forCellReuseIdentifier: String(describing: RepoTableViewCell.self))
        
        setupConstraints()
        
        viewModel.getRepos()
    }
    
    private func setupConstraints() {
        tv.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tv)
        tv.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tv.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tv.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tv.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupBinding() {
        viewModel.$viewControllerTitle
            .compactMap { $0 }
            .assign(to: \.title, on: self)
            .store(in: &viewModel.cancellables)
        viewModel.$repoList
            .sink { _ in
                self.tv.reloadData()
            }
            .store(in: &viewModel.cancellables)

    }
}

extension ResposListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.reposCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RepoTableViewCell.self)) as? RepoTableViewCell else { return UITableViewCell() }
        
        let repo = viewModel.repoList[indexPath.row]
        
        cell.titleLabel.text = repo.name
        
        return cell
    }
}
