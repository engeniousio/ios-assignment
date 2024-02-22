//
//  ViewController.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import UIKit
import Combine

final class RepoViewController: UITableViewController {
    private var viewModel: RepoViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        
        setupNavigationBar()
        setupTableView()
        setupHeaderView()
        registerCells()
    }
    
    private func initViewModel() {
        viewModel = RepoViewModel()
        viewModel.$repoList
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView?.reloadData()
            }
            .store(in: &viewModel.cancellables)
    }
    
    private func setupNavigationBar() {
        title = viewModel.title
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
    }
    
    private func setupHeaderView() {
        let headerWidth = tableView.frame.width
        let headerView = RepoHeaderView(frame: .init(origin: .zero, size: .init(width: headerWidth, height: 50)))
        tableView.tableHeaderView = headerView
    }
    
    private func registerCells() {
        tableView.register(RepoTableViewCell.self)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repoList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = viewModel.getCellViewModel(indexPath: indexPath)
        let cell = tableView.dequeue(RepoTableViewCell.self, forIndexPath: indexPath)
        cell.viewModel = viewModel
        
        return cell
    }
}

