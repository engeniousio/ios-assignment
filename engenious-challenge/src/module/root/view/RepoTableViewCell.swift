import UIKit

// MARK: - RepoTableViewCell

final class RepoTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = UIColor(0x006AB7)
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var subtitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = UIColor(0x00487C)
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.locations = [0, 1]
        layer.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer.endPoint = CGPoint(x: 0.75, y: 0.5)
        layer.colors = [
            UIColor(0xD6EEFF).withAlphaComponent(0.6).cgColor,
            UIColor(0xB7E1FF).withAlphaComponent(0.45).cgColor
        ]
        layer.cornerRadius = 10
        layer.shadowColor = UIColor(0x006AB7).cgColor
        layer.shadowRadius = 12
        layer.shadowOffset = .init(width: 0, height: 6)
        layer.shadowOpacity = 0.08
        return layer
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        
        contentView.addSubview(containerView)
        containerView.layer.addSublayer(gradientLayer)
        containerView.addSubview(titleLabel)
        containerView.addSubview(subtitleLabel)
        
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
        
    override func layoutSubviews() {
        super.layoutSubviews()
        
        CATransaction.performWithoutAnimation {
            gradientLayer.frame = containerView.layer.bounds
        }
    }
    
    func layout() {
        
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.5).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.5).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16).isActive = true
        titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16).isActive = true
        
        subtitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16).isActive = true
        subtitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16).isActive = true
        subtitleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16).isActive = true
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
    }
        
    // MARK: - Config
    
    func config(with model: Repo) {
        titleLabel.text = model.name
        subtitleLabel.text = model.description
    }
}
