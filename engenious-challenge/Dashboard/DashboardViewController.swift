//
//  ViewController.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import UIKit
import Combine

class DashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let repositoryService: RepositoryService = RepositoryService()
    let username: String = "Apple"
    var repoList: [Repo] = []
    
    let tv = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        title = "\(username)'s repos"
        navigationController?.navigationBar.prefersLargeTitles = true

        tv.delegate = self
        tv.dataSource = self
        tv.register(RepositoryTableViewCell.self, forCellReuseIdentifier: String(describing: RepositoryTableViewCell.self))
        tv.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tv)
        tv.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tv.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tv.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tv.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        getRepos()
    }

    func getRepos() {
        repositoryService.getUserRepos(username: username) { value in
            DispatchQueue.main.async {
                self.repoList = value
                self.tv.reloadData()
            }
        }
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

