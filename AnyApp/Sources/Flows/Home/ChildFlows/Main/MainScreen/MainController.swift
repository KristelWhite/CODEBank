import UI
import UIKit

final class MainController: TemplateViewController<MainView> {

    typealias ViewModel = MainViewModel

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
//        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Главная"
        navigationController?.navigationBar.barTintColor = Palette.Surface.backgroundPrimary
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Palette.Text.primary]
        
    }

    private func setupBindings() {
        viewModel.onOutput = { [weak self] output in
            switch output {
            case .content(let props):
                self?.rootView.configured(with: props)
            }
        }

        rootView.onNewProduct = { [weak self] in
            SnackCenter.shared.showSnack(withProps: .init(message: "!New Product"))
        }
    }
}
