//
//  BaseController.swift
//  engenious-challenge
//
//  Created by Юлія Воротченко on 11.01.2024.
//

import UIKit
import Combine

class BaseController<T: BaseViewModel>: UIViewController {

    //MARK: - Properties
    var viewModel: T
    var hideNavigationBar: Bool = false

    
    lazy var cancellable: Set<AnyCancellable> = {
        return Set<AnyCancellable>()
    }()
        
    
    //MARK: - Init
    init(viewModel: T) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind(viewModel: viewModel)
        self.bindStates()
    }

    
    //MARK: - Methods
    func bind(viewModel: T){
        fatalError("Please override bind function")
    }
        
    func bindStates(){
        self.viewModel.isLoading
            .sink { [weak self] isLoading in
                guard let self = self else { return }
                if isLoading { self.startLoading() }
                else { self.stopLoading() }
            }.store(in: &cancellable)
    }
}

