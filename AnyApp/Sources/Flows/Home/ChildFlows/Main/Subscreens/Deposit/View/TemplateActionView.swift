//
//  TemplateActionView.swift
//  AnyApp
//
//  Created by Кристина Пастухова on 24.04.2024.
//

import UIKit
import UI
import AppIndependent

final class TemplateActionView: BackgroundPrimary {

    // MARK: - Private Properties

    private let titleLabel = Label(foregroundStyle: .textSecondary, fontStyle: .body2)
    private let image = ImageView().size(CGSize(width: 24, height: 24), priority: .required)
    private let accessoryImage = ImageView(image: Asset.chevronDown.image).size(CGSize(width: 24, height: 24), priority: .required)

    private var props: Props?

    // MARK: - Public methods

    override public func setup() {
        super.setup()
        body().embed(in: self)
    }

    private func body() -> UIView {
        HStack(spacing: 16) {
            Shimmer()
                .size(CGSize(width: 24, height: 24))
            VStack {
                FlexibleGroupedSpacer()
                Shimmer()
                    .size(CGSize(width: 100, height: 20))
                FlexibleGroupedSpacer()
            }
            .linkGroupedSpacers()
        }
        .layoutMargins(.make(vInsets: 16))
    }

    // MARK: - Private methods

    private func body(with props: Props) -> UIView {
        HStack(spacing: 16) {

            image
                .image(props.image)
                .foregroundStyle(.textTertiary)

            VStack {
                FlexibleGroupedSpacer()
                titleLabel
                    .text(props.title)
                FlexibleGroupedSpacer()
            }
            .linkGroupedSpacers()

            accessoryImage
                .foregroundStyle(.textTertiary)
                    .isHidden(!props.isAccesory)
        }
        .layoutMargins(.make(vInsets: 16))
        .onTap { [weak self] in
            self?.props?.onTap?(props.id)
        }
    }
}

// MARK: - Configurable

extension TemplateActionView: ConfigurableView {

    typealias Model = Props

    struct Props: Hashable {
        let id: String
        let title: String
        let image: UIImage
        let isAccesory: Bool

        var onTap: StringHandler?

        public static func == (lhs: TemplateActionView.Props, rhs: TemplateActionView.Props) -> Bool {
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
