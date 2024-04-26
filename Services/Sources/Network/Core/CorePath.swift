//
//  CorePath.swift
//  Services
//
//  Created by Кристина Пастухова on 24.04.2024.
//

import Core

enum CorePath: Path, CaseIterable {
    case profile
    case accountsList
    case depositsList
    case accountInfo(id: Int)

    static var allCases: [CorePath] {
           return [.profile, .accountsList, .depositsList, .accountInfo(id: 0)]
       }

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
        case .accountInfo(let id):
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
        case .accountInfo(let id):
            return "\(version)core/account/\(id)"
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
        case .accountInfo(let id):
            return .core(.accountInfo)
        }
    }
}

