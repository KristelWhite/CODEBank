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
            title: Main.main,
            image: Asset.star.image,
            selectedImage: Asset.star.image
        )

        guard let profileController = createProfileController() else {
            fatalError("Error during initialization of ProfileController")
        }
        profileController.tabBarItem = .init(title: Profile.profile, image: Asset.camera1.image, selectedImage: Asset.camera1.image
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
    }
}
