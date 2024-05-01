//
//  ProfileFlowCoordinator.swift
//  AnyApp
//
//  Created by Кристина Пастухова on 17.04.2024.
//

import Core
import Services
import Swinject
import AppIndependent
import SwinjectAutoregistration

final class ProfileFlowCoordinator: Coordinator {
    
    var finishFlow: DefaultFinishHandler?

    // MARK: - Private Properties

    private let appSession: AppSession = resolver ~> AppSession.self
    private let innerRouter: RouterAbstract

    // MARK: - ProfileFlowCoordinator

    public init(
        rootRouter: RouterAbstract,
        innerRouter: RouterAbstract
    ) {
        self.innerRouter = innerRouter
        super.init(router: rootRouter)
    }

    required init(router: any RouterAbstract) {
        fatalError("init(router:) has not been implemented")
    }

    func profileController() -> UIViewController? {
        let controller = resolver ~> ProfileController.self

        controller.onEvent = { [weak self] event in
            switch event {
            case .aboutApp:
                self?.showAboutApp()
            case .onTheme:
                self?.showTheme()
            }
        }
        innerRouter.setRootModule(controller)
        return innerRouter.rootController
    }

    func showAboutApp() {
        let controller = resolver ~> (AboutAppController.self)
        controller.hidesBottomBarWhenPushed = true
        innerRouter.push(controller)
    }

    func showTheme() {
        let controller = resolver ~> (ThemeController.self)
        controller.hidesBottomBarWhenPushed = true
        innerRouter.push(controller)
    }
}
