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

    // MARK: - Private Properties

    private let appSession: AppSession = resolver ~> AppSession.self

    // MARK: - ProfileFlowCoordinator

    public convenience init(rootRouter: RouterAbstract) {
        self.init(router: rootRouter)
    }

    func mainController() -> UIViewController? {
        let controller = resolver ~> ProfileController.self 
        router.setRootModule(controller)
        return router.rootController
    }
}

