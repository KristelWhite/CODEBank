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
        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationItem.title = "Главная"
//        var view = View()
//        var label = Label(text: "Главная", foregroundStyle: .textPrimary, fontStyle: .title)
        var view = UIView()
        var label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        navigationItem.titleView = view
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
