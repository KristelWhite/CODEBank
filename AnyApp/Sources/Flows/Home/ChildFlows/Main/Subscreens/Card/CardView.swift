//
//  CardView.swift
//  AnyApp
//
//  Created by Кристина Пастухова on 01.05.2024.
//

import UI
import UIKit
import AppIndependent

final class CardView: BackgroundPrimary {
    enum Event {
        case loadData
    }
    var onEvent: ((Event) -> Void)?


    private let tableView = BaseTableView()
    private lazy var dataSource = CardDataSource(tableView: tableView)
    private var refreshControl = UIRefreshControl()


    override func setup() {
        super.setup()
        body().embed(in: self)
        setupRefreshController()
    }
    private func setupRefreshController() {
        refreshControl.attributedTitle = NSAttributedString(string: "Потяните, чтобы обновить")
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    @objc func refreshData() {
        onEvent?(.loadData)
    }

    private func body() -> UIView {
        VStack {
            tableView
        }
        .layoutMargins(.make(hInsets: 16))
    }
}

extension CardView: ConfigurableView {
    typealias Model = CardViewProps

    func configure(with model: CardViewProps) {
        dataSource.apply(sections: model.sections)
        refreshControl.endRefreshing()
    }
}


