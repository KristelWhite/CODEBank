//
//  CardCellFactory.swift
//  AnyApp
//
//  Created by Кристина Пастухова on 01.05.2024.
//

import UIKit
import UI

final class CardCellFactory {

    // MARK: - Private Properties

    private let tableView: BaseTableView

    // MARK: - Initializers

    init(tableView: BaseTableView) {
        self.tableView = tableView
    }

    // MARK: - Common

    func makeCardHeaderShimmer(for indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: HeaderCardView.self,
            for: indexPath
        )
    }

    func makeActionShimmer(for indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: TemplateActionView.self,
            for: indexPath
        )
    }

    func makePaymentShimmer(for indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: TemplatePaymentView.self,
            for: indexPath
        )
    }
    func makeHistoryShimmer(for indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: TemplateHistoryView.self,
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
            forView: HeaderView.self,
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
        with props: HeaderView.Props
    ) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: HeaderView.self,
            for: indexPath
        ) { view, _ in
            view.configure(with: props)
        }
    }
    func makeTemplateCardHeaderCell(
        for indexPath: IndexPath,
        with props: HeaderCardView.Props
    ) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: HeaderCardView.self,
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
