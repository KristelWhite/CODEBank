//
//  ThemeController.swift
//  AnyApp
//
//  Created by Кристина Пастухова on 21.04.2024.
//

import UI
import UIKit

final class ThemeController: TemplateViewController<ThemeView> {

    typealias ViewModel = ThemeViewModel

    private var viewModel: ViewModel!

    convenience init(viewModel: ViewModel) {
        self.init()
        self.viewModel = viewModel
    }

    override func setup() {
        super.setup()
    }
}
