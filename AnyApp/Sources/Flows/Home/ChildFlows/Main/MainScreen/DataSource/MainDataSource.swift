import UIKit
import UI

final class MainDataSource {

    typealias Section = MainViewProps.Section
    typealias Item = MainViewProps.Item
    typealias DiffableDataSource = UITableViewDiffableDataSource<Section, Item>

    // MARK: - Private properties

    public var dataSource: DiffableDataSource?
    private let tableView: BaseTableView
    private let cellFactory: MainCellFactory

    // MARK: - Init

    init(tableView: BaseTableView) {
        self.tableView = tableView
        self.cellFactory = MainCellFactory(tableView: tableView)
        setup()
        configure()
    }

    // MARK: - Public Methods

    public func apply(sections: [Section]) {
        var snap = NSDiffableDataSourceSnapshot<Section, Item>()
        snap.appendSections(sections)
        sections.forEach {
            snap.appendItems($0.items, toSection: $0)
        }
        dataSource?.apply(snap, animatingDifferences: false)
    }

    // MARK: - Private methods

    private func setup() {
        tableView.contentInsets(.init(top: 0, left: 0, bottom: 92, right: 0))
        tableView.registerTemplateCell(forView: DepositViewCell.self)
        tableView.registerTemplateCell(forView: HeaderViewCell.self)
        tableView.registerTemplateCell(forView: CardViewCell.self)
        tableView.registerTemplateCell(forView: AccountViewCell.self)
    }

    private func configure() {
        dataSource = DiffableDataSource(tableView: tableView) { [unowned self] _, indexPath, item in
            switch item {
            case .header(let props):
                return cellFactory.makeTemplateHeaderCell(for: indexPath, with: props)
            case .account(let props):
                return cellFactory.makeTemplateAccountCell(for: indexPath, with: props)
            case .card(let props):
                return cellFactory.makeTemplateCardCell(for: indexPath, with: props)
            case .deposit(let props):
                return cellFactory.makeTemplateCell(for: indexPath, with: props)
            case .shimmerAccount:
                return cellFactory.makeAccountShimmer(for: indexPath)
            case .shimmerHeader:
                return cellFactory.makeHeaderShimmer(for: indexPath)
            case .shimmerDeposit:
                return cellFactory.makeDepositShimmer(for: indexPath)
            case .shimmerCard:
                return cellFactory.makeCardShimmer(for: indexPath)
            }
        }
    }
}
