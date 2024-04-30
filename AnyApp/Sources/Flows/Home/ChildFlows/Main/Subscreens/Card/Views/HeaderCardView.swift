//
//  HeaderCardView.swift
//  AnyApp
//
//  Created by Кристина Пастухова on 01.05.2024.
//

import UIKit
import UI
import AppIndependent
import Services
import Core

final class HeaderCardView: BackgroundPrimary {

    // MARK: - Private Properties

    private var props: Props?

    // MARK: - Public methods

    override public func setup() {
        super.setup()
        body().embed(in: self)
    }

    // MARK: - Private methods

    private func body() -> UIView {
        VStack {
            BackgroundView(hPadding: 24) {
                Shimmer()
            }
            .shadowStyle(.dropShadow1)
            .size(CGSize(width: 272, height: 158), priority: .required)
        }
        .layoutMargins(.make(vInsets: 16, hInsets: 24))

    }


    private func body(with props: Props) -> UIView {
        ZStack {
            BackgroundView {
                ImageView(image: Asset.bg.image)
                    .cornerRadius(10)
                    .clipsToBounds(true)
            }
            .shadowStyle(.dropShadow1)
            VStack {
                HStack {
                    ImageView(image: props.paymentSystem.image)
                        .size(CGSize(width: 32, height: 24), priority: .required)
                    Spacer(.px16)
                    Label(text: props.name, foregroundStyle: .textPrimary, fontStyle: .body2)
                        .multiline()
                    FlexibleSpacer()
                    ImageView(image: Asset.payPass.image, foregroundStyle: .contentAccentTertiary)
                }
                FlexibleGroupedSpacer()
                Label(text: props.value.formattedAsCurrency(props.currency.sign), foregroundStyle: .textPrimary, fontStyle: .subtitle2)
                FlexibleGroupedSpacer()
                HStack(distribution: .equalSpacing) {
                    Label(text: props.cardNumber.maskCardNumber(), foregroundStyle: .textSecondary, fontStyle: .caption1)
                    Spacer(.px16)
                    Label(text: DefaultParsers.Date.convertDate(fromString: props.date, fromFormat: .iso, toFormat: .cardHeader), foregroundStyle: .textSecondary, fontStyle: .caption1)
                }
            }
            .size(CGSize(width: 272, height: 158), priority: .required)
            .layoutMargins(.make(vInsets: 24, hInsets: 16))
            .linkGroupedSpacers()
        }
        .layoutMargins(.make(vInsets: 16, hInsets: 24))
    }
}
// MARK: - Configurable

extension HeaderCardView: ConfigurableView {

    typealias Model = Props

    struct Props: Hashable {
        let id: Int
        let name: String
        let cardNumber: String
        let currency: Currency
        let value: Double
        let date: String
        let paymentSystem: PaymentSystem

        var onTap: StringHandler?

        public static func == (lhs: HeaderCardView.Props, rhs: HeaderCardView.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(name)
            hasher.combine(cardNumber)
            hasher.combine(currency)
            hasher.combine(value)
            hasher.combine(date)
        }
    }

    func configure(with model: Props) {
        self.props = model
        subviews.forEach { $0.removeFromSuperview() }
        body(with: model).embed(in: self)
    }
}

