//
//  DepositeController.swift
//  AnyApp
//
//  Created by Кристина Пастухова on 24.04.2024.
//

import UI
import UIKit

final class DepositController: TemplateViewController<DepositView> {

    typealias ViewModel = DepositViewModel
    
    enum Event {
       

    }

    var onEvent: ((Event) -> Void)?


    private var viewModel: ViewModel!

    convenience init(viewModel: ViewModel) {
        self.init()
        self.viewModel = viewModel
    }

    override func setup() {
        super.setup()
        setupBindings()
        configureNavigationItem()
        viewModel.handle(.loadData)
    }

    private func configureNavigationItem() {
        navigationItem.title = "Счета"
    }

    private func setupBindings() {
        viewModel.onOutput = { [weak self] output in
            switch output {
            case .content(let props):
                self?.rootView.configure(with: props)
                print("configure with \(props)")
            case .error(let errorProps):
                self?.setAdditionState(.error(errorProps))
            case .removeState:
                self?.removeAdditionalState()
            }
        }
        rootView.onEvent = { [weak self] event in
            switch event {
            case .loadData:
                self?.viewModel.handle(.loadData)
            }
        }
    }
}

