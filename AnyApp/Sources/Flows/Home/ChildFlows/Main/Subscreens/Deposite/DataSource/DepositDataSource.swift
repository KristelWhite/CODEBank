//
//  DepositDataSource.swift
//  AnyApp
//
//  Created by Кристина Пастухова on 24.04.2024.
//

import UIKit
import UI

final class DepositDataSource {

    typealias Section = DepositViewProps.Section
    typealias Item = DepositViewProps.Item
    typealias DiffableDataSource = UITableViewDiffableDataSource<Section, Item>

    // MARK: - Private properties

    public var dataSource: DiffableDataSource?
    private let tableView: BaseTableView
    private let cellFactory: DepositCellFactory

    // MARK: - Init

    init(tableView: BaseTableView) {
        self.tableView = tableView
        self.cellFactory = DepositCellFactory(tableView: tableView)
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
        tableView.registerTemplateCell(forView: TemplateShimmerView.self)
        tableView.registerTemplateCell(forView: TemplateHistoryView.self)
        tableView.registerTemplateCell(forView: TemplateHeaderView.self)
        tableView.registerTemplateCell(forView: TemplatePaymentView.self)
        tableView.registerTemplateCell(forView: TemplateActionView.self)
        tableView.registerTemplateCell(forView: SwitchView.self)
        tableView.registerTemplateCell(forView: HeaderDepositView.self)
    }

    private func configure() {
        dataSource = DiffableDataSource(tableView: tableView) { [unowned self] _, indexPath, item in
            switch item {
            case .shimmer:
                return cellFactory.makeShimmer(for: indexPath)
            case .header(let props):
                return cellFactory.makeTemplateHeaderCell(for: indexPath, with: props)
            case .action(let props):
                return cellFactory.makeTemplateActionCell(for: indexPath, with: props)
            case .history(let props):
                return cellFactory.makeTemplateHistoryCell(for: indexPath, with: props)
            case .payment(let props):
                return cellFactory.makeTemplatePaymentCell(for: indexPath, with: props)
            case .switchView(let props):
                return cellFactory.makeSwitchCell(for: indexPath, with: props)  
            case .depositHeader(let props):
                return cellFactory.makeTemplateDepositHeaderCell(for: indexPath, with: props)
            }
        }
    }
}
