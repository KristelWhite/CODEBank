//
//  HeaderDepositeView.swift
//  AnyApp
//
//  Created by Кристина Пастухова on 26.04.2024.
//

import UIKit
import UI
import AppIndependent

final class HeaderDepositView: BackgroundPrimary {

    // MARK: - Private Properties

    private var props: Props?

    // MARK: - Public methods

    override public func setup() {
        super.setup()

    }

    // MARK: - Private methods


    private func body(with props: Props) -> UIView {
        VStack( alignment: .center, distribution: .fill ) {
            BackgroundView {
                ImageView( foregroundStyle: .contentAccentTertiary)
                    .image(props.currency.imageValue)
            }
            .cornerRadius(26)
            .backgroundStyle(.contentSecondary)
            .size(CGSize(width: 52, height: 52))
            Spacer(.px16)
            Label(foregroundStyle: .textPrimary, fontStyle: .body15)
                .text(props.name)
            Spacer(.px4)
            Label(foregroundStyle: .textSecondary, fontStyle: .caption1)
                .text(props.cardNumber)
            Spacer(.px8)
            Label(foregroundStyle: .textPrimary, fontStyle: .title28)
                .text(String(props.value))
        }
        .layoutMargins(.make(vInsets: 16))
    }
}

// MARK: - Configurable

extension HeaderDepositView: ConfigurableView {
    
    typealias Model = Props
    
    struct Props: Hashable {
        let id: Int
        let name: String
        let cardNumber: String
        let currency: Currency
        let value: Int
        
        var onTap: StringHandler?
        
        public static func == (lhs: HeaderDepositView.Props, rhs: HeaderDepositView.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(name)
            hasher.combine(cardNumber)
            hasher.combine(currency.textValue)
            hasher.combine(value)
        }
    }
    
    func configure(with model: Props) {
        self.props = model
        subviews.forEach { $0.removeFromSuperview() }
        body(with: model).embed(in: self)
    }
}
