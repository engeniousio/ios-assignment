import UIKit

// MARK: - RepoSectionHeaderView

final class RepoSectionHeaderView: UIView {
    
    // MARK: - Properties
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor(0x006AB7)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Repositories"
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.5).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
