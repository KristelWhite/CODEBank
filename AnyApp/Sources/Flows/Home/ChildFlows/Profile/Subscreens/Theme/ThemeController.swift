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
    
    var appearanceManager = AppearanceManager.shared

    private var viewModel: ViewModel!

    convenience init(viewModel: ViewModel) {
        self.init()
        self.viewModel = viewModel
    }

    override func setup() {
        super.setup()
        self.navigationItem.title = Profile.theme
        setupBindings()
    }
    
    private func setupBindings() {
        rootView.onChangeTheme = { [weak self] theme in
            self?.appearanceManager.setTheme(theme)
            print("поменяли на тему \(theme)")
            self?.rootView.setNeedsLayout()
        }
    }
}
