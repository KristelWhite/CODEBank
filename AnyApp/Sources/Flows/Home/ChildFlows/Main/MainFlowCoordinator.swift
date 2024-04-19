import Core
import Services
import Swinject
import AppIndependent
import SwinjectAutoregistration

final class MainFlowCoordinator: Coordinator {

    var finishFlow: DefaultFinishHandler?

    // MARK: - Private Properties

    private let appSession: AppSession = resolver ~> AppSession.self

    private let innerRouter: RouterAbstract

    // MARK: - MainFlowCoordinator

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

    func mainController() -> UIViewController? {
        let controller = resolver ~> MainController.self
        innerRouter.setRootModule(controller)
        return innerRouter.rootController
    }
}
