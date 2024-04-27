//
//  CorePath.swift
//  Services
//
//  Created by Кристина Пастухова on 24.04.2024.
//

import Core

enum CorePath: String, Path, CaseIterable {
    case profile
    case accountsList
    case depositsList
    case accountInfo

    var version: String {
        "6096726/api/"
    }
   

    var id: String {
        switch self {
        case .profile:
            return "profile"
        case .accountsList:
            return "accountList"
        case .depositsList:
            return "depositList"
        case .accountInfo:
            return "accountInfo"
        }
    }

    public var endpoint: String {
        switch self {
        case .profile:
            return "\(version)core/profile"
        case .accountsList:
            return "\(version)core/account/list"
        case .depositsList:
            return "\(version)core/deposit/list"
        case .accountInfo:
            return "\(version)core/account/{id}"
        }
    }

    var method: HttpMethod { return .get }

    var requestContext: RequestContext {
        switch self {
        case .profile:
            return .core(.profile)
        case .accountsList:
            return .core(.accountsList)
        case .depositsList:
            return .core(.depositsList)
        case .accountInfo:
            return .core(.accountInfo)
        }
    }
}

