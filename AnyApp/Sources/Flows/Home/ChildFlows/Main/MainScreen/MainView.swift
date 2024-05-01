import UI
import Core
import UIKit
import AppIndependent

final class MainView: BackgroundPrimary {

    enum Input {
        case showButton
    }

    enum Event {
        case loadData
    }

    var onEvent: ((Event) -> Void)?

    var onNewProduct: VoidHandler?

    private let tableView = BaseTableView()

    private let button = ButtonPrimary(title: Main.newProgect)
    private lazy var dataSource = MainDataSource(tableView: tableView)
    var refreshControl = UIRefreshControl()

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
        setupRefreshController()
    }

    private func body() -> UIView {
        VStack {
            tableView
        }
        .layoutMargins(.make(vInsets: 0, hInsets: 16))
    }

    private func setupRefreshController() {
        refreshControl.attributedTitle = NSAttributedString(string: Common.pullToUpdate)
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    @objc func refreshData() {
        onEvent?(.loadData)
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
        refreshControl.endRefreshing()
    }
}
