//
//  ViewController.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import UIKit

class RepoListViewController: BaseViewController {

    let tableView = UITableView()
    
    var viewModel:RepoLostViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        viewModel.getRepositories()
    }
    
    override func loadView() {
        super.loadView()
        loadUI()
    }
}


extension RepoListViewController:RepoLostViewModelPresenter {
    func requestCompleted() {
        tableView.reloadData()
    }
}


//MARK: loadUI
extension RepoListViewController {
    func loadUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        tableView.register(RepoTableViewCell.self, forCellReuseIdentifier: String(describing: RepoTableViewCell.self))
        tableView.register(SectionHeaderTableCell.self, forCellReuseIdentifier: String(describing: SectionHeaderTableCell.self))

        view.addSubview(tableView)
    }
    
    func updateUI() {
        viewModel = .init(presenter:self)
        title = viewModel.navigationTitle
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        setConstraints()
    }
    
    private func setConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}


//MARK: UITableViewDelegate
extension RepoListViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let data = viewModel.repoList.count
        return data == 0 ? 1 : data
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if viewModel.repoList.count == 0 || apiError != nil {
            return UITableViewCell()
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RepoTableViewCell.self)) as? RepoTableViewCell else { return UITableViewCell() }
            let repo = viewModel.repoList[indexPath.row]
            cell.setCell(repo)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SectionHeaderTableCell.self)) as! SectionHeaderTableCell
        cell.set(title: viewModel.sectionTitle)
        return cell.contentView
    }
}
