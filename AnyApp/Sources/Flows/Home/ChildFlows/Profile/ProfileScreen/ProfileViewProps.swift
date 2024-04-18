//
//  ProfileViewProps.swift
//  AnyApp
//
//  Created by Кристина Пастухова on 18.04.2024.
//

import Foundation

struct ProfileViewProps {
    let settiongs: [Settings]
}

enum Settings: CaseIterable {
    case aboutApp
    case theme
    case support
    case exit
    
    var description: TemplateSettingsView.Props {
        switch self {
        case .aboutApp:
            return .init(id: "1", title: "О приложении", image: Asset.settings.image, isAccesory: true)
        case .theme:
            return .init(id: "2", title: "то", image: Asset.moonStars.image , isAccesory: true)
        case .support:
            return .init(id: "3", title: "ото", image: Asset.phoneCall.image, isAccesory: false)
        case .exit:
            return .init(id: "4", title: "ио", image: Asset.accountOut.image, isAccesory: false)
        }
    }
    
}
