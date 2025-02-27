//
//  TemplateAccountView.swift
//  AnyApp
//
//  Created by Кристина Пастухова on 16.04.2024.
//

import UIKit
import UI
import AppIndependent
import Services

final class AccountViewCell: BackgroundPrimary {

    // MARK: - Private Properties

    private let titleLabel = Label(foregroundStyle: .textPrimary, fontStyle: .body2)
    private let valueLabel = Label(foregroundStyle: .contentAccentPrimary, fontStyle: .body2)
    private let image = ImageView(foregroundStyle: .contentAccentTertiary)
    private let accessoryImage = ImageView(image: Asset.chevronUp.image, foregroundStyle: .contentTertiary)

    private var props: Props?

    // MARK: - Public methods

    override public func setup() {
        super.setup()
        body().embed(in: self)
    }

    // MARK: - Private methods
    private func body() -> UIView {
        HStack(spacing: 16) {
            VStack {
                Shimmer()
                .size(.init(width: 40, height: 40), priority: .required)
            }
            VStack( spacing: 2) {
                Shimmer()
                    .size(CGSize(width: 160, height: 20))
                Shimmer()
                    .size(CGSize(width: 90, height: 20))
            }
            VStack {
                FlexibleGroupedSpacer()
                Shimmer()
                .size(.init(width: 40, height: 28), priority: .required)
                FlexibleGroupedSpacer()
            }
            .linkGroupedSpacers()
        }
        .layoutMargins(.make(vInsets: 16))
        }

    private func body(with props: Props) -> UIView {
        HStack(spacing: 16) {
            VStack {
                BackgroundView {
                    image
                        .image(props.currency.imageValue)
                }
                .backgroundStyle(.contentSecondary)
                .size(.init(width: 40, height: 40), priority: .required)
                .cornerRadius(20)
            }
            VStack(distribution: .fillEqually, spacing: 2) {
                titleLabel
                    .text(props.title)
                valueLabel
                    .text(props.value.formattedAsCurrency(props.currency.sign))
            }
            VStack {
                FlexibleGroupedSpacer()
                BackgroundView {
                    accessoryImage
                }
                .backgroundStyle(.contentSecondary)
                .size(.init(width: 40, height: 28), priority: .required)
                .cornerRadius(4)
                FlexibleGroupedSpacer()
            }
            .linkGroupedSpacers()
        }
        .layoutMargins(.make(vInsets: 16))
        .onTap { [weak self] in
            self?.props?.onTap?(props.id)
        }
    }
}

// MARK: - Configurable
extension AccountViewCell: ConfigurableView {

    typealias Model = Props

    struct Props: Hashable {
        let id: Int
        let title: String
        let value: Double
        let currency: Currency

        var onTap: IntHandler?

        public static func == (lhs: AccountViewCell.Props, rhs: AccountViewCell.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(title)
            hasher.combine(value)
            hasher.combine(currency)
        }
    }

    public func configure(with model: Props) {
        self.props = model
        subviews.forEach { $0.removeFromSuperview() }
        body(with: model).embed(in: self)
    }
}
