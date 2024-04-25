//
//  AccoutInfoResponse.swift
//  Services
//
//  Created by Кристина Пастухова on 25.04.2024.
//

import Foundation

public struct AccountInfoResponse: Decodable {
    public let number: String
    public let status: String
    public let balance: Double
    public let currency: Currency
    public let accountId: Int
}

public enum Currency: String, Decodable {
    case rub = "RUB"
    case usd = "USD"
    case eur = "EUR"
}

//{
//  "number": "0467683482412661",
//  "status": "Активен",
//  "balance": 12,
//  "currency": "RUB",
//  "accountId": 0
//}
