//
//  CardView.swift
//  AnyApp
//
//  Created by Кристина Пастухова on 01.05.2024.
//

import UI
import UIKit
import AppIndependent

final class CardInfoView: BackgroundPrimary {
    enum Event {
        case loadData
    }
    var onEvent: ((Event) -> Void)?

    private let tableView = BaseTableView()
    private var refreshControl = UIRefreshControl()
    private lazy var dataSource = CardDataSource(tableView: tableView)

    override func setup() {
        super.setup()
        body().embed(in: self)
        setupRefreshController()
    }

    private func body() -> UIView {
        VStack {
            tableView
        }
        .layoutMargins(.make(hInsets: 16))
    }

    private func setupRefreshController() {
        refreshControl.attributedTitle = NSAttributedString(string: Common.pullToUpdate)
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    @objc private func refreshData() {
        onEvent?(.loadData)
    }
}

extension CardInfoView: ConfigurableView {
    typealias Model = CardViewProps

    func configure(with model: CardViewProps) {
        dataSource.apply(sections: model.sections)
        refreshControl.endRefreshing()
    }
}


