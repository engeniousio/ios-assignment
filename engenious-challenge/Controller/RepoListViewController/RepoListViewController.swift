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
        let refreshedError = (tableView.refresh?.isRefreshing ?? false) && viewModel.repoList.count != 0
        let showingError = title != viewModel.navigationTitle
        
        if refreshedError && !showingError {
            title = apiError?.message.title ?? "Error updeting data"
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(6), execute: {
                self.title = self.viewModel.navigationTitle
            })
        }
        tableView.reloadData()
    }
}


//MARK: loadUI
extension RepoListViewController {
    func loadUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = K.Colors.background
        tableView.backgroundColor = K.Colors.background
        registerCells()
        view.addSubview(tableView)
    }
    
    func updateUI() {
        viewModel = .init(presenter:self)
        title = viewModel.navigationTitle
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        setConstraints()
        tableView.refreshAction = self.viewModel.getRepositories
    }
    
    private func setConstraints() {
        tableView.addConstaits([.left:0, .right:0, .top:0, .bottom:0])
    }
    
    
    private func registerCells() {
        tableView.register(RepoTableViewCell.self, forCellReuseIdentifier: String(describing: RepoTableViewCell.self))
        tableView.register(SectionHeaderTableCell.self, forCellReuseIdentifier: String(describing: SectionHeaderTableCell.self))
        tableView.register(MessageTableViewCell.self, forCellReuseIdentifier: String(describing: MessageTableViewCell.self))
    }
}

