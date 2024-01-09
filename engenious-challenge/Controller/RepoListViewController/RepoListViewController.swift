//
//  ViewController.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import UIKit

class RepoListViewController: BaseViewController {

    let tableView = LoadingTableView()
    
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
        view.backgroundColor = K.Colors.background
        tableView.backgroundColor = K.Colors.background
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
        tableView.refreshAction = viewModel.getRepositories
    }
    
    private func setConstraints() {
        tableView.addConstaits([.left:0, .right:0, .top:0, .bottom:0])
    }
}

