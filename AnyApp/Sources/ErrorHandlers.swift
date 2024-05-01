//
//  ErrorUIHandler.swift
//  AnyApp
//
//  Created by Кристина Пастухова on 30.04.2024.
//

import UI
import Core
import AppIndependent

public enum ErrorUIHandler {
    static func handle(_ error: ErrorWithContext, onTap: @escaping VoidHandler) -> ErrorView.Props {
        switch error.appError.kind {
        case .network:
            return ErrorView.Props(
                title: Common.atention,
                message: Common.Error.networkingError,
                image: Asset.bigIlustrtionNotWiFi.image,
                buttonTitle: Common.repeat,
                onTap: onTap
            )
        default:
            return ErrorView.Props(
                title: Common.Error.defaultTitle,
                message: Common.Error.defaultMessagePity,
                image: Asset.bigIlustrtion1.image,
                buttonTitle: Common.repeat,
                onTap: onTap
            )
        }
    }
}

public enum ErrorServerHandler {
    static func handle(_ error: ErrorWithContext) {
        switch error.appError.kind {
        case .network:
            SnackCenter.shared.showSnack(withProps: .init(message: Common.Error.snakNetworkingError, style: .error))
        default:
            SnackCenter.shared.showSnack(withProps: .init(message: Common.Error.defaultSnak, style: .error))
        }
    }
}
