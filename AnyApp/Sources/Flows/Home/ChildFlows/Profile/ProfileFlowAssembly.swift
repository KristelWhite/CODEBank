//
//  ProfileFlowAssembly.swift
//  AnyApp
//
//  Created by Кристина Пастухова on 17.04.2024.
//

import UI
import Core
import Swinject
import Services
import AppIndependent
import SwinjectAutoregistration

final class ProfileFlowAssembly: Assembly, Identifiable {

    var id: String { String(describing: type(of: self)) }

    func assemble(container: Container) {
        container.register(BaseNavigationController.self, name: RouterName.profile) { _ in
            BaseNavigationController(navigationBarClass: NavigationBar.self, toolbarClass: nil)
        }
        .inObjectScope(.weak)

        container.register(Router.self, name: RouterName.profile) { resolver in
            let navigationController = resolver ~> (BaseNavigationController.self, name: RouterName.profile)
            return Router(rootController: navigationController)
        }
        .inObjectScope(.weak)

        container.register(ProfileFlowCoordinator.self) { resolver in
            let innerRouter = resolver ~> (Router.self, name: RouterName.profile)
            let router = resolver ~> (Router.self, name: RouterName.profile)
            return ProfileFlowCoordinator(rootRouter: router, innerRouter: innerRouter) 
        }

        container.register(ProfileController.self) { resolver in
            let viewModel = ProfileViewModel(appSession: resolver ~> AppSession.self)
            return ProfileController(viewModel: viewModel)
        }
        
        container.register(AboutAppController.self) { resolver in
            let viewModel = AboutAppViewModel()
            return AboutAppController(viewModel: viewModel)
        }
        container.register(ThemeController.self) { resolver in
            let viewModel = ThemeViewModel()
            return ThemeController(viewModel: viewModel)
        }
    }

    func loaded(resolver: Resolver) {
        Logger().debug(id, "is loaded")
    }
}

