//
//  TemplateThemeView.swift
//  AnyApp
//
//  Created by Кристина Пастухова on 22.04.2024.
//

import UIKit
import UI
import AppIndependent

final class TemplateThemeView: BackgroundPrimary {

    // MARK: - Private Properties

    private let titleLabel = Label(foregroundStyle: .contentAccentTertiary, fontStyle: .body2)
    private let accessoryImage = ImageView(image: Asset.radioOff.image)
        .size(CGSize(width: 24, height: 24), priority: .required)
    
    private var props: Props?

    // MARK: - Public methods

    override public func setup() {
        super.setup()
    }

    
    override func updateAppearance() {
        super.updateAppearance()
        guard let theme = props?.theme else { return }
        accessoryImage.image = isCurrentTheme(theme: theme) ? Asset.radioOk.image : Asset.radioOff.image
    }

    // MARK: - Private methods
    
    
    private func body(with props: Props) -> UIView {
        HStack( spacing: 16) {
            VStack {
                Spacer(.custom(length: 3))
                titleLabel
                    .text(props.title)
                Spacer(.custom(length: 1))
            }
            accessoryImage
                .foregroundStyle(.textTertiary)
                .image(isCurrentTheme(theme: props.theme) ? Asset.radioOk.image : Asset.radioOff.image)
        }
        .layoutMargins(.all(16))
        .onTap { [weak self] in
            self?.props?.onTap?(props.id)
        }
    }
    
    func isCurrentTheme(theme: ThemeRaw) -> Bool {
        let currentTheme = AppearanceManager.shared.themeRaw
        return currentTheme == theme
    }
    
}

// MARK: - Configurable

extension TemplateThemeView: ConfigurableView {
    
    typealias Model = Props
    
    struct Props: Hashable {
        let id: String
        let title: String
        let theme: ThemeRaw
        
        var onTap: StringHandler?
        
        public static func == (lhs: TemplateThemeView.Props, rhs: TemplateThemeView.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(title)
            hasher.combine(theme)
        }
    }

    public func configure(with model: Props) {
        self.props = model
        subviews.forEach { $0.removeFromSuperview() }
        body(with: model).embed(in: self)
    }
    
}


