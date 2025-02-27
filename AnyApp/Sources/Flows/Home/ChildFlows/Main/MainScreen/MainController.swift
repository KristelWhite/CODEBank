import UI
import UIKit

final class MainController: TemplateViewController<MainView> {

    typealias ViewModel = MainViewModel

    enum Event {
        case selectCard(with: String)
        case selectAccount(with: Int)
    }

    var onEvent: ((Event) -> Void)?

    private var viewModel: ViewModel!

    convenience init(viewModel: ViewModel) {
        self.init()
        self.viewModel = viewModel
    }

    override func setup() {
        super.setup()
        setupBindings()
        configureNavigationItem()
        viewModel.handle(.loadData)
    }

    private func configureNavigationItem() {
        navigationItem.title = Main.main
    }

    private func setupBindings() {
        viewModel.onOutput = { [weak self] output in
            switch output {
            case .content(let props):
                self?.rootView.configured(with: props)
            case .selectCard(with: let id):
                self?.onEvent?(.selectCard(with: id))
            case .selectAccount(with: let id):
                self?.onEvent?(.selectAccount(with: id))
            case .error(let errorProps):
                self?.setAdditionState(.error(errorProps))
            case .loader:
                break
            case .removeState:
                self?.removeAdditionalState()
            case .showActionButton:
                self?.rootView.handle(input: .showButton)
            }
        }

        rootView.onEvent = { [weak self] event in
            switch event {
            case .loadData:
                self?.viewModel.handle(.loadData)
            }
        }

        rootView.onNewProduct = {
            SnackCenter.shared.showSnack(withProps: .init(message: Common.duringDevelopment))
        }
    }
}
