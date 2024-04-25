//
//  DepositeListResponse.swift
//  Services
//
//  Created by Кристина Пастухова on 25.04.2024.
//

import Foundation

public struct Deposit: Decodable {
    public var depositId: Int
    public var balance: Double
    public var currency: String
    public var status: String
    public var name: String?
}

public struct DepositsListResponse: Decodable {
    public var deposits: [Deposit]
}
