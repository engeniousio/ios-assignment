//
//  File.swift
//  engenious-challenge
//
//  Created by Юлія Воротченко on 11.01.2024.
//

import Foundation
import Combine

protocol ViewModel {
    var isLoading: PassthroughSubject<Bool, Never> { get }
    var displayMessage: PassthroughSubject<String?, Never> { get }
}

class BaseViewModel: ViewModel {
    var cancellable = Set<AnyCancellable>()
    var isLoading: PassthroughSubject<Bool, Never> = .init()
    var displayMessage: PassthroughSubject<String?, Never> = .init()
}
