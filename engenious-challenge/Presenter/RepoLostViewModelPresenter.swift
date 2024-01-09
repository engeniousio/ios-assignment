//
//  RepoLostViewModelPresenter.swift
//  engenious-challenge
//
//  Created by Misha Dovhiy on 09.01.2024.
//

import Foundation

protocol RepoLostViewModelPresenter {
    var apiError:APIError? { get set }
    func requestCompleted()
}
