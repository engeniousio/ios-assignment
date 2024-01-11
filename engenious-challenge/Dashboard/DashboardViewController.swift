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
        let headerView = createTableHeaderView()
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
        tv.separatorStyle = .none
        tv.tableHeaderView = headerView
        getRepos()
    }
    
    func createTableHeaderView() -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100)) // Adjust the height as needed
        
        // Customize your header view as per your design
        let headerLabel = UILabel()
        headerLabel.textColor = .listTitleColor
        headerLabel.text = "Table View Header"
        headerLabel.textAlignment = .left
        headerLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(headerLabel)
        
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            headerLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 40)
        ])
        
        return headerView
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

