//
//  CardInfoResponse.swift
//  Services
//
//  Created by Кристина Пастухова on 01.05.2024.
//

import Foundation

public struct CardInfoResponse: Decodable {
    public let number: String
    public let status: String
    public let id: Int
    public let name: String
    public let accountId: Int
    public let expiredAt: String //Date
    public let paymentSystem: PaymentSystem
}
