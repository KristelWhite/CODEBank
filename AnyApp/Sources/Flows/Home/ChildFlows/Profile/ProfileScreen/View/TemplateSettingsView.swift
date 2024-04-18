//
//  TemplateSettingsView.swift
//  AnyApp
//
//  Created by Кристина Пастухова on 18.04.2024.
//

import UIKit
import UI
import AppIndependent

final class TemplateSettingsView: BackgroundPrimary {

    // MARK: - Private Properties

    private let titleLabel = Label(foregroundStyle: .textPrimary, fontStyle: .body2)
    private let image = ImageView().size(CGSize(width: 24, height: 24), priority: .required)
    private let accessoryImage = ImageView(image: Asset.chevronRight.image).size(CGSize(width: 24, height: 24),priority: .required)
    
    private var props: Props?

    // MARK: - Public methods

    override public func setup() {
        super.setup()
    }

    // MARK: - Private methods
    
    
    private func body(with props: Props) -> UIView {
        HStack( spacing: 16) {
            image
                .image(props.image)
                .foregroundStyle(.textTertiary)
            VStack {
                Spacer(.px2)
                titleLabel
                    .text(props.title)
                Spacer(.px2)
            }
            accessoryImage
                .foregroundStyle(.textTertiary)
                .isHidden(!props.isAccesory)
        }
        .layoutMargins(.make(vInsets: 16, hInsets: 16))
        .onTap { [weak self] in
            self?.props?.onTap?(props.id)
        }
    }
    
    
}

// MARK: - Configurable

extension TemplateSettingsView: ConfigurableView {
    
    typealias Model = Props
    
    struct Props: Hashable {
        let id: String
        let title: String
        let image: UIImage
        let isAccesory: Bool
        
        var onTap: StringHandler?
        
        public static func == (lhs: TemplateSettingsView.Props, rhs: TemplateSettingsView.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(title)
            hasher.combine(image)
            hasher.combine(isAccesory)
        }
    }

    public func configure(with model: Props) {
        self.props = model
        subviews.forEach { $0.removeFromSuperview() }
        body(with: model).embed(in: self)
    }
}

