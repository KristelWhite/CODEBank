import UI
import Core
import Services
import Swinject
import AppIndependent
import SwinjectAutoregistration

final class HomeFlowCoordinator: Coordinator {

    required init(router: RouterAbstract) {
        super.init(router: router)
    }

    override func start() {
        showTabController()
    }

    private func showTabController() {
        guard topController(ofType: TabController.self) == nil else { return }

        guard let mainController = createMainController() else {
            fatalError("Error during initialization of MainController")
        }
        mainController.tabBarItem = .init(
            title: "Главная",
            image: UIImage(systemName: "star"),
            selectedImage: UIImage(systemName: "star")
        )

        guard let profileController = createProfileController() else {
            fatalError("Error during initialization of ProfileController")
        }
        profileController.tabBarItem = .init(title: "Профиль", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star")
        )


        let controllers = [
            mainController,
            profileController
        ]

        let tabController = resolver ~> (TabController.self, controllers)

        router.setRootModule(tabController)
    }
}

private extension HomeFlowCoordinator {

    func createMainController() -> UIViewController? {
        DIContainer.shared.assemble(assembly: MainFlowAssembly())

        let coordinator = resolver ~> (MainFlowCoordinator.self, router)
        
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
        }
        addDependency(coordinator)

        return coordinator.mainController()
    }

    func createProfileController() -> UIViewController? {
        DIContainer.shared.assemble(assembly: ProfileFlowAssembly())
        
        let coordinator = resolver ~> ProfileFlowCoordinator.self
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
        }
        addDependency(coordinator)
        
        return coordinator.profileController()
//        let viewModel = ProfileViewModel(appSession: resolver ~> AppSession.self)
//        let controller = ProfileController(viewModel: viewModel)
//        controller.tabBarItem = .init(title: "Профиль", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star"))
//        return controller
    }
}
