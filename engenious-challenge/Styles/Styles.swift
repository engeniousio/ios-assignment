//
//  Styles.swift
//  engenious-challenge
//
//  Created by Никита Бабанин on 18/01/2024.
//

import UIKit

class RepositoryTableViewStyle: RepositoryTableViewStyling {
    var titleLabelFont = UIFont.boldSystemFont(ofSize: 16)
    var titleLabelColor = UIColor(hex: "#006AB7")
    var subtitleLabelColor = UIColor(hex: "#00487C")
    var backgroundColor = UIColor(hex: "#D6EEFF")
}
 
class RepositoryHeaderStyle: RepositoryHeaderStyling {
    var headerLabelColor = UIColor(hex: "006AB7")
    var headerLabelFont = UIFont.systemFont(ofSize: 20, weight: .bold)
}
