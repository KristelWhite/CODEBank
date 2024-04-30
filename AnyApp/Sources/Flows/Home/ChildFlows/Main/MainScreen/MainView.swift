import UI
import UIKit
import AppIndependent

final class MainView: BackgroundPrimary {

    enum Input {
        case showButton
    }

    var onNewProduct: VoidHandler?

    private let tableView = BaseTableView()
    private let button = ButtonPrimary(title: "Открыть новый счет или продукт")
    private lazy var dataSource = MainDataSource(tableView: tableView)

    func handle(input: Input) {
        switch input {
        case .showButton:
            button
                .isHidden(false)
        }
    }

    override func setup() {
        super.setup()
        body().embed(in: self)
        setupButton()

    }

    private func body() -> UIView {
        VStack {
            tableView
        }
        .layoutMargins(.make(vInsets: 0, hInsets: 16))
    }

    private func setupButton() {
        addSubview(button)
        button.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(24)
            $0.height.equalTo(52)
        }
        button
            .isHidden(true)
            .onTap { [weak self] in
            self?.onNewProduct?()
        }
    }

//    ScrollView {
//        VStack {
//            HStack {
//                profileAvatarHeaderView
//                Spacer(.px20)
//                ForEach(collection: settings, spacing: 30) {
//                    Label(text: $0.rawValue)
//                }
//            }
//        }
//    }
}

extension MainView: ConfigurableView {
    typealias Model = MainViewProps

    func configure(with model: MainViewProps) {
        dataSource.apply(sections: model.sections)
    }
}
