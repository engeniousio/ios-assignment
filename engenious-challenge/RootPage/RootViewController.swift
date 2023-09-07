//
//  ViewController.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import UIKit
import Combine

class RootViewController<View: RootView, ViewModel: RootViewModel>: UIViewController {
    
    var viewModel: ViewModel? {
        didSet {
            guard let viewModel else { return }
            bind(with: viewModel)
            currentView.setup(dataSource: viewModel.dataSource)
        }
    }
    
    private var subscriptions = Set<AnyCancellable>()
    
    var currentView: View {
        view as! View
    }
    
    // MARK: Overrides
    
    override func loadView() {
        view = View()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.fetchRepos()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    // MARK: Bind
    
    private func bind(with viewModel: ViewModel) {
        subscriptions.removeAll()
        subscribeToUpdateTitle(viewModel.$pageTitle.eraseToAnyPublisher())
        subscribeToProcessLoadingState(viewModel.$isLoading.eraseToAnyPublisher())
    }
    
    private func subscribeToUpdateTitle(_ publisher: AnyPublisher<String, Never>) {
        publisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.title = value
            }
            .store(in: &subscriptions)
    }
    
    private func subscribeToProcessLoadingState(_ publisher: AnyPublisher<Bool, Never>) {
        publisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                // some page loading
            }
            .store(in: &subscriptions)
    }
}
