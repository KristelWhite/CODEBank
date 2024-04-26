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

    func makeShimmer(for indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: TemplateShimmerView.self,
            for: indexPath
        )
    }

    // MARK: - Cells

    func makeTemplateActionCell(
        for indexPath: IndexPath,
        with props: TemplateActionView.Props
    ) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: TemplateActionView.self,
            for: indexPath
        ) { view, _ in
            view.configure(with: props)
        }
    }
    func makeTemplatePaymentCell(
        for indexPath: IndexPath,
        with props: TemplatePaymentView.Props
    ) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: TemplatePaymentView.self,
            for: indexPath
        ) { view, _ in
            view.configure(with: props)
        }
    }
    func makeTemplateHistoryCell(
        for indexPath: IndexPath,
        with props: TemplateHistoryView.Props
    ) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: TemplateHistoryView.self,
            for: indexPath
        ) { view, _ in
            view.configure(with: props)
        }
    }

    func makeTemplateHeaderCell(
        for indexPath: IndexPath,
        with props: TemplateHeaderView.Props
    ) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: TemplateHeaderView.self,
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

