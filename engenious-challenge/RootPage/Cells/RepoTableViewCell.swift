//
//  RepoTableViewCell.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import Combine
import UIKit

final class RepoTableViewCell: UITableViewCell, FillableCell {
    
    // MARK: Constants
    
    private enum Constants {
        static let titleInsets = UIEdgeInsets(top: 16, left: 16, bottom: -16, right: -16)
    }
    
    static let cellIdentifier = "RepoTableViewCell"
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: UI

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: Configure views
    
    private func configureViews() {
        configureLabel()
    }
    
    private func configureLabel() {
        let insets = Constants.titleInsets
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: insets.top),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: insets.left),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: insets.right),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: insets.bottom)
        ])
    }
    
    // MARK: FillableCell
    
    func fill(by cellModel: CellViewModel) {
        titleLabel.text = (cellModel as? RepoCellModel)?.title
        bind(with: cellModel)
    }
    
    // MARK: Bind
    
    private func bind(with cellModel: CellViewModel) {
        subscriptions.removeAll()
        guard let cellModel = cellModel as? RepoCellModel else { return }
        cellModel.$title
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak titleLabel] value in
                titleLabel?.text = value
            }
            .store(in: &subscriptions)
    }
}
