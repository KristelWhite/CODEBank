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
   

    var id: String {
        switch self {
        case .profile:
            return "profile"
        case .accountsList:
            return "accountList"
        case .depositsList:
            return "depositeList"
        case .accountInfo:
            return "accountInfo"
        }
    }

    public var endpoint: String {
        switch self {
        case .profile:
            return "core/profile"
        case .accountsList:
            return "core/account/list"
        case .depositsList:
            return "core/deposit/list"
        case .accountInfo:
            return "core/account"
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

