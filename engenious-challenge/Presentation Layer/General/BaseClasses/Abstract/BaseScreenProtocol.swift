//
//  BaseScreenProtocol.swift
//  engenious-challenge
//
//  Created by admin on 14.01.2024.
//

import Foundation

protocol BaseScreenProtocol {
    
    func afterViewLoaded(perform action: @escaping () -> Void) -> Bool
}
