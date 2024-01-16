//
//  Helpers.swift
//  engenious-challenge
//
//  Created by Никита Бабанин on 15/01/2024.
//

import Foundation

public protocol ControlSetup {
    func setupSubviews()
    func setupAutoLayout()
    func setupStyle()
    func setupActions()
}

public extension ControlSetup {
    func setupActions() { }
    
    func controlSetup() {
        setupSubviews()
        setupAutoLayout()
        setupStyle()
        setupActions()
    }
}
