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
//{
//  "id": 0,
//  "name": "test",
//  "number": "2323200814106608",
//  "status": "Активна",
//  "accountId": 0,
//  "expiredAt": "2022-04-21T00:00:00Z",
//  "paymentSystem": "VISA"
//}
