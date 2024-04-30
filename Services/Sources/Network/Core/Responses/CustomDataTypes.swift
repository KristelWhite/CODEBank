//
//  CustomDataTypes.swift
//  AnyApp
//
//  Created by Кристина Пастухова on 30.04.2024.
//

import UIKit
import UI

public enum Currency: String, Decodable {
    case rub = "RUB"
    case usd = "USD"
    case eur = "EUR"

    public var imageValue: UIImage {
        switch self {
        case .rub:
            return Asset.ruble.image
        case .usd:
            return Asset.icUsd.image
        case .eur:
            return Asset.icEur.image
        }
    }

    public var sign: String {
        switch self {
        case .rub:
            return "₽"
        case .usd:
            return "$"
        case .eur:
            return "€"
        }
    }
}

// MARK: - платежная система карты
public enum PaymentSystem: String, Decodable {
    case visa = "Visa"
    case visa1 = "VISA"
    case masterCard = "MasterCard"

    public var image: UIImage {
        switch self {
        case .visa:
            return Asset.visa.image
        case .masterCard:
            return Asset.masterCard.image
        case .visa1:
            return Asset.visa.image
        }
    }
}

// MARK: - активна ли карта
public enum CardState: String, Equatable, Codable {
    case closed, physical, digital

    public var textValue: String {
        switch self {
        case .closed:
            return "Закрыта"
        case .physical:
            return "Физическая"
        case .digital:
            return "Цифровая"
        }
    }
    public var label: Label {
        switch self {
        case .closed:
            return Label(text: self.textValue, foregroundStyle: .indicatorContentError, fontStyle: .caption1)
        case .physical, .digital:
            return Label(text: self.textValue, foregroundStyle: .textSecondary, fontStyle: .caption1)
        }
    }
    public var colorCardNumber: ForegroundStyle {
        switch self {
        case .closed:
            return .textSecondary
        case .physical, .digital:
            return .contentAccentTertiary
        }
    }
}
