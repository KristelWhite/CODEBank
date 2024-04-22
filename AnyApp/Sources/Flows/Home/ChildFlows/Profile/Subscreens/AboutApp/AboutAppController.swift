//
//  AboutAppController.swift
//  AnyApp
//
//  Created by Кристина Пастухова on 21.04.2024.
//

import UI
import UIKit

final class AboutAppController: TemplateViewController<AboutAppView> {

    typealias ViewModel = AboutAppViewModel

    private var viewModel: ViewModel!

    convenience init(viewModel: ViewModel) {
        self.init()
        self.viewModel = viewModel
    }

    override func setup() {
        super.setup()
        self.navigationItem.title = "О приложении"
    }
}
