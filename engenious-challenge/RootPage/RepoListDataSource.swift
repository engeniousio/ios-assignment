//
//  RepoListDataSource.swift
//  engenious-challenge
//
//  Created by Mikita Dzmitrievich on 7.09.23.
//

import UIKit

class RepoListDataSource: NSObject, UITableViewDataSource {
    
    private(set) var cellModels: [CellViewModel]
    
    weak var tableView: UITableView? {
        didSet {
            if let tableView {
                registerCells(in: tableView)
            }
        }
    }
    
    init(with cellModels: [CellViewModel]) {
        self.cellModels = cellModels
    }
    
    @MainActor
    func updateCellModels(to cellModels: [CellViewModel]) {
        self.cellModels = cellModels
        tableView?.reloadSections(IndexSet(integer: .zero), with: .automatic)
    }
    
    func registerCells(in tableView: UITableView) {
        // need to register by interface with cellViewModels
        // this is "Костыль"
        tableView.register(RepoTableViewCell.self, forCellReuseIdentifier: "RepoTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard cellModels.count > indexPath.item else { return .init() }
        let cellModel = cellModels[indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.cellIdentifier, for: indexPath)
        cellModel.fillableCell = cell as? FillableCell
        return cell
    }
}
