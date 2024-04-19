//
//  ProfileViewProps.swift
//  AnyApp
//
//  Created by Кристина Пастухова on 18.04.2024.
//

import UIKit

struct ProfileViewProps {
    let name: String
    let image: UIImage
    let phone: String
}

enum Settings: CaseIterable {
    case aboutApp
    case theme
    case support
    case exit
    
    var description: TemplateSettingsView.Props {
        switch self {
        case .aboutApp:
            return .init(id: "1", title: "О приложении", image: Asset.settings.image, isAccesory: true){ _ in
                
            }
        case .theme:
            return .init(id: "2", title: "Тема приложения", image: Asset.moonStars.image , isAccesory: true)
        case .support:
            return .init(id: "3", title: "Служба поддержки", image: Asset.phoneCall.image, isAccesory: false)
        case .exit:
            return .init(id: "4", title: "Выход", image: Asset.accountOut.image, isAccesory: false)
        }
    }
    
}
