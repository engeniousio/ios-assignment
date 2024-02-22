//
//  RepoTableViewCell.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import UIKit

final class RepoTableViewCell: BaseTableViewCell {
    private let stackView: GradientStackView = GradientStackView()
    
    private let titleLabel: UILabel = UILabel()
    private let subtitleLabel: UILabel = UILabel()
    
    var viewModel: ViewModelProtocol? {
        didSet {
            guard let viewModel = viewModel as? RepoCellViewModel else {
                return
            }
            setupCell(viewModel: viewModel)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupStackView()
        setupTitleLabel()
        setupSubtitleLabel()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        [titleLabel, subtitleLabel].forEach { $0.text = nil }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell(viewModel: RepoCellViewModel) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
    }
    
    private func setupStackView() {
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 16.0
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.setCornerRadius(10.0)
        stackView.shadowOffset = .init(width: 0.0, height: 6.0)
        stackView.shadowRadius = 6.0
        
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 14.0),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -14.0),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16.0)
        ])
    }
    
    private func setupTitleLabel() {
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textColor = #colorLiteral(red: 0, green: 0.4156862745, blue: 0.7176470588, alpha: 1)
        titleLabel.numberOfLines = 0
        stackView.addArrangedSubview(titleLabel)
    }
    
    private func setupSubtitleLabel() {
        subtitleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        subtitleLabel.textColor = #colorLiteral(red: 0, green: 0.2823529412, blue: 0.4862745098, alpha: 1)
        subtitleLabel.numberOfLines = 0
        stackView.addArrangedSubview(subtitleLabel)
    }
}
