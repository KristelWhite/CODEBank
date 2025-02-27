//
//  ProfileResponse.swift
//  Services
//
//  Created by Кристина Пастухова on 24.04.2024.
//

import Foundation

public struct ProfileResponse: Decodable {
    public let id: Int
    public let firstName: String
    public let middleName: String
    public let lastName: String
    public let country: String
    public let phone: String
}
