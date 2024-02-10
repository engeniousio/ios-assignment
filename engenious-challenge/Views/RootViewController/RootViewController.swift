//
//  ViewController.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import UIKit
import Combine

final class RootViewController: UITableViewController {
    private var viewModel: RootViewViewModel
    private var cancellablesBag = Set<AnyCancellable>()
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: RootViewViewModel) {
        self.viewModel = viewModel
        super.init(style: .grouped)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitle()
        setupTableView()
        bind()
        viewModel.loadDataCombine() // loadDataCallback()
    }
    
    private func setupTitle() {
        self.title = viewModel.userName
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(RepoTableViewCell.self, forCellReuseIdentifier: Constants.cellReuseIdentifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = Constants.tableViewBackgroundColor
    }
    
    private func bind() {
        viewModel.items
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellablesBag)
    }
    
    private func configureCell(for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellReuseIdentifier, for: indexPath) as? RepoTableViewCell else {
            fatalError("Cannot create new cell")
        }
        cell.configure(with: self.viewModel.getReposCellViewModelBy(index: indexPath.row))
        return cell
    }
}

extension RootViewController {
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        
        let headerLabel = UILabel()
        headerLabel.font = UIFont.systemFont(ofSize: Constants.headerLabelFontSize, weight: .semibold)
        headerLabel.textColor = Constants.headerLabelTextColor
        headerLabel.text = Constants.headerLabelText
        
        let stackView = UIStackView(arrangedSubviews: [headerLabel])
        stackView.axis = .vertical
        stackView.layoutMargins = Constants.headerStackViewLayoutMargins
        stackView.isLayoutMarginsRelativeArrangement = true
        
        headerView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: headerView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor)
        ])
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.heightForHeaderInSection
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.value.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureCell(for: indexPath)
    }
}

private enum Constants {
    static let cellReuseIdentifier: String = "ReposTableViewCell"
    
    static let tableViewBackgroundColor: UIColor = .white
    
    static let headerLabelFontSize: CGFloat = 20
    static let headerLabelTextColor: UIColor = UIColor(red: 0/255.0, green: 106/255.0, blue: 183/255.0, alpha: 1)
    static let headerLabelText: String = "Repositories"
    
    static let headerStackViewLayoutMargins: UIEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
    
    static let heightForHeaderInSection: CGFloat = 60
}
