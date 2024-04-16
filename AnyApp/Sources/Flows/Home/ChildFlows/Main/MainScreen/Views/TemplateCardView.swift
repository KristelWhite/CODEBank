//
//  TemplateCardView.swift
//  AnyApp
//
//  Created by Кристина Пастухова on 16.04.2024.
//

import UIKit
import UI
import AppIndependent

final class TemplateCardView: BackgroundPrimary {

    // MARK: - Private Properties

    private let titleLabel = Label(foregroundStyle: .textPrimary, fontStyle: .body2)
    private let image = ImageView(image: Asset.input.image).size(CGSize(width: 24, height: 24))
    private let stateLabel = Label(foregroundStyle: .textSecondary, fontStyle: .caption1)
    
    private var props: Props?

    // MARK: - Public methods

    override public func setup() {
        super.setup()

    }

    // MARK: - Private methods
    
    
    private func body(with props: Props) -> UIView {
        HStack(spacing: 16) {
            VStack {
                Spacer(.px8)
                HStack {
                    Spacer(.px8)
                    image
                    Spacer(.custom(length: 7))
                }
                Spacer(.px8)
            }
            VStack(distribution: .fillEqually, spacing: 3) {
                titleLabel
                    .text(props.title)
                stateLabel
                    .text(props.description)
            }
            VStack {
                Spacer(.px6)
                BackgroundPrimary(backgroundStyle: .contentSecondary)
                    .size(CGSize(width: 40, height: 28), priority: .required)
                Spacer(.custom(length: 5))
            }
        }
        .layoutMargins(.init(top: 16, left: 0, bottom: 17, right: 0))
        .onTap { [weak self] in
            self?.props?.onTap?(props.id)
        }
    }
}

// MARK: - Configurable

extension TemplateCardView: ConfigurableView {

    typealias Model = Props

    struct Props: Hashable {
        let id: String
        let title: String
        let description: String

        var onTap: StringHandler?

        public static func == (lhs: TemplateCardView.Props, rhs: TemplateCardView.Props) -> Bool {
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


