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
        case selectCard(with: String)
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
            case .profileInfo(let props):
                self?.rootView.configure(with: props)
            }
        }

//        rootView.onNewProduct = { [weak self] in
//            SnackCenter.shared.showSnack(withProps: .init(message: "!New Product"))
//        }
    }
}

