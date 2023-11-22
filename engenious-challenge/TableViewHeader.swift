//
//  TableViewHeader.swift
//  engenious-challenge
//
//  Created by Sofia Gorlata on 22.11.2023.
//

import UIKit

class TableViewHeader: UIView {
    
    let title: UILabel
    
    init() {
        self.title = UILabel()
        super.init(frame: CGRect(x: 0, y: 0, width: 334, height: 40))
        
        addSubview(title)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        title.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        title.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        title.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true
        
        title.font = title.font.withSize(20)
        title.textColor = Colors.blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
