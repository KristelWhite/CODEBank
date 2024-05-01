import UIKit
import UI

final class MainCellFactory {

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

    func makeAccountShimmer(for indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: AccountViewCell.self,
            for: indexPath
        )
    }

    func makeDepositShimmer(for indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: DepositViewCell.self,
            for: indexPath
        )
    }

    func makeCardShimmer(for indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: CardViewCell.self,
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

    func makeTemplateAccountCell(
        for indexPath: IndexPath,
        with props: AccountViewCell.Props
    ) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: AccountViewCell.self,
            for: indexPath
        ) { view, _ in
            view.configure(with: props)
        }
    }
    func makeTemplateCell(
        for indexPath: IndexPath,
        with props: DepositViewCell.Props
    ) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: DepositViewCell.self,
            for: indexPath
        ) { view, _ in
            view.configure(with: props)
        }
    }
    func makeTemplateCardCell(
        for indexPath: IndexPath,
        with props: CardViewCell.Props
    ) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: CardViewCell.self,
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
}
