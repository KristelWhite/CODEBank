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
            forView: TemplateAccountView.self,
            for: indexPath
        )
    }

    func makeDepositShimmer(for indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: TemplateDepositView.self,
            for: indexPath
        )
    }

    func makeCardShimmer(for indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: TemplateCardView.self,
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

    func makeTemplateAccountCell(
        for indexPath: IndexPath,
        with props: TemplateAccountView.Props
    ) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: TemplateAccountView.self,
            for: indexPath
        ) { view, _ in
            view.configure(with: props)
        }
    }
    func makeTemplateCell(
        for indexPath: IndexPath,
        with props: TemplateDepositView.Props
    ) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: TemplateDepositView.self,
            for: indexPath
        ) { view, _ in
            view.configure(with: props)
        }
    }
    func makeTemplateCardCell(
        for indexPath: IndexPath,
        with props: TemplateCardView.Props
    ) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: TemplateCardView.self,
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
}
