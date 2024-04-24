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
        controller.onEvent = { [weak self] event in
            switch event {
            case .selectCard(with: let id):
                self?.showDeposit()
                break
            }
        }
        innerRouter.setRootModule(controller)
        return innerRouter.rootController
    }
    func showDeposit() {
        let controller = resolver ~> (DepositController.self)
        controller.hidesBottomBarWhenPushed = true
        innerRouter.push(controller)
    }
    
}
