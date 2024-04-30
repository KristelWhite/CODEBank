//
//  ErrorUIHandler.swift
//  AnyApp
//
//  Created by Кристина Пастухова on 30.04.2024.
//

import UI
import Core
import AppIndependent

public struct ErrorUIHandler {
    static func handle(_ error: ErrorWithContext, onTap: @escaping VoidHandler) -> ErrorView.Props {
        switch error.appError.kind {
        case .network:
            return ErrorView.Props(
                title: "Внимание",
                message: "Вероятно, соединение с интрнетом прервано",
                image: Asset.bigIlustrtionNotWiFi.image,
                buttonTitle: "Повторить",
                onTap: onTap
            )
        default:
            return ErrorView.Props(
                title: Common.Error.defaultTitle,
                message: Common.Error.defaultMessagePity,
                image: Asset.bigIlustrtion1.image,
                buttonTitle: "Повторить",
                onTap: onTap
            )
        }
    }
}

public struct ErrorServerHandler {
    static func handle(_ error: ErrorWithContext) {
        switch error.appError.kind {
        case .network:
            SnackCenter.shared.showSnack(withProps: .init(message: "Соединение с интернетом потеряно", style: .error))
        default:
            SnackCenter.shared.showSnack(withProps: .init(message: "Возникла какая-то ошибка", style: .error))
        }
    }
}

