//
//  ThemeView.swift
//  AnyApp
//
//  Created by Кристина Пастухова on 21.04.2024.
//

import UI
import UIKit
import AppIndependent

final class ThemeView: BackgroundPrimary {
    
    var onChangeTheme: ((ThemeRaw) -> Void)?
    
    var themes: [ThemeRaw] = [.auto, .dark, .light]
    
    func isCurrentTheme(theme: ThemeRaw) -> Bool {
        let currentTheme = AppearanceManager.shared.themeRaw
        return currentTheme == theme
    }
    
    func handle(with theme: ThemeRaw) -> TemplateThemeView.Props {
        switch theme {
        case .auto:
            return .init(id: "1", title: "Как в системе", theme: .auto) { [weak self] _ in
                self?.onChangeTheme?(.auto)
            }
        case .light:
            return .init(id: "2", title: "Светлая", theme: .light) { [weak self] _ in
                self?.onChangeTheme?(.light)
            }
        case .dark:
            return .init(id: "3", title: "Темная", theme: .dark) { [weak self] _ in
                self?.onChangeTheme?(.dark)
            }
        }
    }
    
    override func setup() {
        super.setup()
        body().embed(in: self)
    }
    
    private func body() -> UIView {
        VStack {
            ForEach(collection: themes, alignment: .fill, distribution: .fill, axis: .vertical) { [weak self] theme in
                TemplateThemeView()
                    .configured(with: (self?.handle(with: theme))!)
            }
            FlexibleSpacer()
        }
        .layoutMargins(.all(16))
    }
}
