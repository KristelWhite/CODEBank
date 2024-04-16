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
//                stateLabel
//                    .text(props.state)
                props.state.label
            }
            VStack {
                Spacer(.px6)
                ZStack {
                    VStack {
                        ImageView(image: Asset.bankCard.image)
                    }
                    VStack(alignment: .trailing, distribution: .fillEqually, spacing: 1) {
                        Label(text: props.cardNumber, foregroundStyle: props.state.colorCardNumber, fontStyle: .cardNumber)
                        ImageView(image: props.paymentSysem.image)
                    }
                    .layoutMargins(.init(top: 2, left: 4, bottom: 1, right: 4))
                }
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

enum CardState: String, Equatable, Codable {
    case closed, physical
    
    var textValue: String {
        switch self {
        case .closed:
            return "Закрыта"
        case .physical:
            return "Физическая"
        }
    }
    
    var label: Label {
        switch self {
        case .closed:
            return Label(text: self.textValue, foregroundStyle: .indicatorContentError, fontStyle: .caption1)
        case .physical:
            return Label(text: self.textValue, foregroundStyle: .textSecondary, fontStyle: .caption1)
        }
    }
    var colorCardNumber: ForegroundStyle {
        switch self {
        case .closed:
            return .textSecondary
        case .physical:
            return .contentAccentTertiary
        }
    }
    
}

enum PaymentSystem: String, Equatable, Codable {
    case visa, masterCard
    
    var textValue: String {
        switch self {
        case .visa:
            return "Visa"
        case .masterCard:
            return "MasterCard"
        }
    }
    var image: UIImage {
        switch self {
        case .visa:
            return Asset.visa.image
        case .masterCard:
            return Asset.masterCard.image
        }
    }
}

// MARK: - Configurable

extension TemplateCardView: ConfigurableView {

    typealias Model = Props

    struct Props: Hashable {
        let id: String
        let title: String
        let state: CardState
        let cardNumber: String
        let paymentSysem: PaymentSystem

        var onTap: StringHandler?

        public static func == (lhs: TemplateCardView.Props, rhs: TemplateCardView.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(title)
            hasher.combine(state.textValue)
            hasher.combine(cardNumber)
            hasher.combine(paymentSysem.textValue)
        }
    }

    public func configure(with model: Props) {
        self.props = model
        subviews.forEach { $0.removeFromSuperview() }
        body(with: model).embed(in: self)
    }
}


