//
//  ViewController.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import UIKit
import Combine

protocol RootView: AnyObject {
    func updateView()
}

class RootViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var viewModel: ViewModel!
    
    let tv = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        title = "\(viewModel.username)'s repos"
        navigationController?.navigationBar.prefersLargeTitles = true

        tv.delegate = self
        tv.dataSource = self
        tv.register(RepoTableViewCell.self, forCellReuseIdentifier: String(describing: RepoTableViewCell.self))
        tv.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tv)
        tv.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tv.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        tv.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        tv.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        tv.tableHeaderView = TableViewHeader()
        tv.separatorStyle = .none
        tv.showsVerticalScrollIndicator = false

        viewModel.getRepos()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repoList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RepoTableViewCell.self)) as? RepoTableViewCell else { return UITableViewCell() }
        let repo = viewModel.repoList[indexPath.row]
        cell.titleLabel.text = repo.name
        cell.subtitleLabel.text = repo.description
        cell.selectionStyle = .none
        return cell
    }
}

extension RootViewController: RootView {
    func updateView() {
        self.tv.reloadData()
    }
}
