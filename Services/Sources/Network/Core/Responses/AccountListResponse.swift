//
//  AccountListResponse.swift
//  Services
//
//  Created by Кристина Пастухова on 25.04.2024.
//

import Foundation

public struct AccountsListResponse: Decodable {
    public let accounts: [Account]
}

public struct Account: Decodable {
    public let cards: [Card]?
    public let number: String
    public let status: String
    public let balance : Double
    public let currency: Currency
    public let accountId: Int
}

public struct Card: Decodable {
    public let number: String
    public let id: UUID
    public let name: String
    public let status: Status
    public let cardType: CardType
    public let paymentSystem: PaymentSystem

    private enum CodingKeys: String, CodingKey {
        case number
        case id = "card_id"
        case name
        case status
        case cardType = "card_type"
        case paymentSystem = "payment_system"
    }
}

public enum Status: String, Decodable {
    case active = "ACTIVE"
    case deactivated = "DEACTIVATED"
}

public enum CardType: String, Decodable {
    case physical, digital
}
