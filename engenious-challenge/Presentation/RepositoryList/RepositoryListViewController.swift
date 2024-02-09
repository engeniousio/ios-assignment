//
//  RepositoryListViewController.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import UIKit
import Combine

final class RepositoryListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let repositoryService: RepositoryService = RepositoryService()
    let username: String = "Apple"
    var repoList: [RepoDataModel] = []
    
    let repoTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        title = "\(username)'s repos"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        repoTableView.delegate = self
        repoTableView.dataSource = self
        repoTableView.register(
            RepoTableViewCell.self,
            forCellReuseIdentifier: String(describing: RepoTableViewCell.self)
        )
        repoTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(repoTableView)
        repoTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        repoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        repoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        repoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        getRepos()
    }
    
    func getRepos() {
        repositoryService.getUserRepos(username: username) { value in
            DispatchQueue.main.async {
                self.repoList = value
                self.repoTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RepoTableViewCell.self)) as? RepoTableViewCell else { return UITableViewCell() }
        let repo = repoList[indexPath.row]
        cell.titleLabel.text = repo.name
        return cell
    }
}
