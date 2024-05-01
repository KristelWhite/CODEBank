//
//  ThemeController.swift
//  AnyApp
//
//  Created by Кристина Пастухова on 21.04.2024.
//

import UI
import UIKit

final class ThemeController: TemplateViewController<ThemeView> {

    var appearanceManager = AppearanceManager.shared

    override func setup() {
        super.setup()
        self.navigationItem.title = Profile.theme
        setupBindings()
    }

    private func setupBindings() {
        rootView.onChangeTheme = { [weak self] theme in
            self?.appearanceManager.setTheme(theme)
            self?.rootView.setNeedsLayout()
        }
    }
}
