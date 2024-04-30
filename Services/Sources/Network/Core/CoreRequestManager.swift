//
//  CoreRequestManager.swift
//  Services
//
//  Created by Кристина Пастухова on 24.04.2024.
//

import Core
import Combine
import Alamofire

public protocol CoreRequestManagerAbstract: AnyObject {

    func profile() -> AppPublisher<ProfileResponse>
    func accountsList() -> AppPublisher<AccountsListResponse>
    func depositsList() -> AppPublisher<DepositsListResponse>
    func accountInfo(accountId: Int) -> AppPublisher<AccountInfoResponse>
    func cardInfo(cardId: String) -> AppPublisher<CardInfoResponse>
}

final class CoreRequestManager: NetworkRequestManager, CoreRequestManagerAbstract {
    func cardInfo(cardId: String) -> Core.AppPublisher<CardInfoResponse> {
        request(path: CorePath.cardInfo, pathParams: ["id": "\(cardId)"])
    }

    func accountsList() -> Core.AppPublisher<AccountsListResponse> {
        request(path: CorePath.accountsList)
    }

    func depositsList() -> Core.AppPublisher<DepositsListResponse> {
        request(path: CorePath.depositsList)
    }

    func accountInfo(accountId: Int) -> Core.AppPublisher<AccountInfoResponse> {
        request(path: CorePath.accountInfo, pathParams: ["id": "\(accountId)"])
    }

    func profile() -> AppPublisher<ProfileResponse> {
        request(path: CorePath.profile)
    }
}

