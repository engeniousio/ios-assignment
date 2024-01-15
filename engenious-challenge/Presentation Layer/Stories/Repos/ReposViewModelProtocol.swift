//
//  ReposViewModelProtocol.swift
//  engenious-challenge
//
//  Created by admin on 14.01.2024.
//

import Foundation

protocol ReposViewModelProtocol {
    var selectedCategoryPublisher: Published<[Repo]>.Publisher { get }
}
