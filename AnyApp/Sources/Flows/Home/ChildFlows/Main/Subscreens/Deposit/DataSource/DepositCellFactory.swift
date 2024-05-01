//
//  DepositCellFactory.swift
//  AnyApp
//
//  Created by Кристина Пастухова on 24.04.2024.
//

import UIKit
import UI

final class DepositCellFactory {

    // MARK: - Private Properties

    private let tableView: BaseTableView

    // MARK: - Initializers

    init(tableView: BaseTableView) {
        self.tableView = tableView
    }

    // MARK: - Common

    func makeDepositHeaderShimmer(for indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: HeaderDepositView.self,
            for: indexPath
        )
    }

    func makeActionShimmer(for indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: ActionViewCell.self,
            for: indexPath
        )
    }

    func makePaymentShimmer(for indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: PaymentViewCell.self,
            for: indexPath
        )
    }
    func makeHistoryShimmer(for indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: TransactionViewCell.self,
            for: indexPath
        )
    }

    func makeSwitchShimmer(for indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: SwitchView.self,
            for: indexPath
        )
    }

    func makeHeaderShimmer(for indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: HeaderViewCell.self,
            for: indexPath
        )
    }

    // MARK: - Cells

    func makeTemplateActionCell(
        for indexPath: IndexPath,
        with props: ActionViewCell.Props
    ) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: ActionViewCell.self,
            for: indexPath
        ) { view, _ in
            view.configure(with: props)
        }
    }
    func makeTemplatePaymentCell(
        for indexPath: IndexPath,
        with props: PaymentViewCell.Props
    ) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: PaymentViewCell.self,
            for: indexPath
        ) { view, _ in
            view.configure(with: props)
        }
    }
    func makeTemplateHistoryCell(
        for indexPath: IndexPath,
        with props: TransactionViewCell.Props
    ) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: TransactionViewCell.self,
            for: indexPath
        ) { view, _ in
            view.configure(with: props)
        }
    }

    func makeTemplateHeaderCell(
        for indexPath: IndexPath,
        with props: HeaderViewCell.Props
    ) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: HeaderViewCell.self,
            for: indexPath
        ) { view, _ in
            view.configure(with: props)
        }
    }
    func makeTemplateDepositHeaderCell(
        for indexPath: IndexPath,
        with props: HeaderDepositView.Props
    ) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: HeaderDepositView.self,
            for: indexPath
        ) { view, _ in
            view.configure(with: props)
        }
    }

    func makeSwitchCell(
        for indexPath: IndexPath,
        with props: SwitchView.Props
    ) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: SwitchView.self,
            for: indexPath
        ) { view, _ in
            view.configure(with: props)
        }
    }
}
