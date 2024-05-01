//
//  TemplateCardView.swift
//  AnyApp
//
//  Created by Кристина Пастухова on 16.04.2024.
//

import UIKit
import UI
import AppIndependent
import Services

final class CardViewCell: BackgroundPrimary {

    // MARK: - Private Properties

    private let titleLabel = Label(foregroundStyle: .textPrimary, fontStyle: .body2)
    private let image = ImageView(image: Asset.input.image)
        .size(CGSize(width: 24, height: 24))
        .foregroundStyle(.contentTertiary)

    private let stateLabel = Label(foregroundStyle: .textSecondary, fontStyle: .caption1)

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
            VStack(spacing: 3) {
                Shimmer()
                    .size(CGSize(width: 180, height: 20))
                Shimmer()
                    .size(CGSize(width: 120, height: 20))
            }
            VStack {
                FlexibleGroupedSpacer()
                Shimmer()
                .size(CGSize(width: 40, height: 28), priority: .required)
                FlexibleGroupedSpacer()
            }
//            .height(40, priority: .required)
            .linkGroupedSpacers()
        }
        .layoutMargins(.make(vInsets: 16))
    }
    private func body(with props: Props) -> UIView {
        HStack {
            Spacer(.px8)
            VStack {
                FlexibleGroupedSpacer()
                    image
                FlexibleGroupedSpacer()
            }
            .linkGroupedSpacers()
            Spacer(.px24)
            VStack(distribution: .fillEqually, spacing: 3) {
                titleLabel
                    .text(props.title)
                props.state.label
            }
            VStack {
                FlexibleGroupedSpacer()
                ZStack {
                    VStack {
                        ImageView(image: Asset.bankCard.image)
                            .cornerRadius(4)
                            .clipsToBounds(true)
                    }
                    VStack(alignment: .trailing, distribution: .fillEqually, spacing: 1) {
                        Label(text: props.cardNumber.lastFourCharacters, foregroundStyle: props.state.colorCardNumber, fontStyle: .cardNumber)
                        ImageView(image: props.paymentSystem.image)
                    }
                    .layoutMargins(.init(top: 2, left: 4, bottom: 1, right: 4))
                }
                .size(CGSize(width: 40, height: 28), priority: .required)
                FlexibleGroupedSpacer()
            }
            .height(40, priority: .required)
            .linkGroupedSpacers()
        }
        .layoutMargins(.make(vInsets: 16))
        .onTap { [weak self] in
            self?.props?.onTap?(props.id)
        }
    }
}

// MARK: - Configurable

extension CardViewCell: ConfigurableView {

    typealias Model = Props

    struct Props: Hashable {
        let id: String
        let title: String
        let state: CardState
        let cardNumber: String
        let paymentSystem: PaymentSystem

        var onTap: StringHandler?

        public static func == (lhs: CardViewCell.Props, rhs: CardViewCell.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(title)
            hasher.combine(state)
            hasher.combine(cardNumber)
            hasher.combine(paymentSystem)
        }
    }

    public func configure(with model: Props) {
        self.props = model
        subviews.forEach { $0.removeFromSuperview() }
        body(with: model).embed(in: self)
    }
}



