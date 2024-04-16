//
//  TemplateAccountView.swift
//  AnyApp
//
//  Created by Кристина Пастухова on 16.04.2024.
//

import UIKit
import UI
import AppIndependent

final class TemplateAccountView: BackgroundPrimary {

    // MARK: - Private Properties

    private let titleLabel = Label(foregroundStyle: .textPrimary, fontStyle: .body2)
    private let valueLabel = Label(foregroundStyle: .contentAccentPrimary, fontStyle: .body2)
    private let image = ImageView().size(CGSize(width: 40, height: 40))
    private let button = BaseBrandButton(image: Asset.chevronUp.image)
    
    private var props: Props?

    // MARK: - Public methods

    override public func setup() {
        super.setup()
    }

    // MARK: - Private methods
    
    
    private func body(with props: Props) -> UIView {
        HStack(spacing: 16) {
            VStack {
                image
                Spacer(.px2)
            }
            VStack(distribution: .fillEqually, spacing: 2) {
                titleLabel
                    .text(props.title)
                valueLabel
                    .text(props.description)
            }
            VStack {
                Spacer(.px6)
                button
                    .size(.init(width: 40, height: 28), priority: .required)
                    .backgroundColor(Palette.Content.secondary)
                    .cornerRadius(4)
                Spacer(.px8)
            }
            
        }
        .layoutMargins(.init(top: 16, left: 0, bottom: 14, right: 0))
        .onTap { [weak self] in
            self?.props?.onTap?(props.id)
        }
    }
    
   
}

// MARK: - Configurable

extension TemplateAccountView: ConfigurableView {

    typealias Model = Props

    struct Props: Hashable {
        let id: String
        let title: String
        let description: String

        var onTap: StringHandler?

        public static func == (lhs: TemplateAccountView.Props, rhs: TemplateAccountView.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(title)
            hasher.combine(description)
        }
    }

    public func configure(with model: Props) {
        self.props = model
        subviews.forEach { $0.removeFromSuperview() }
        body(with: model).embed(in: self)
    }
}

