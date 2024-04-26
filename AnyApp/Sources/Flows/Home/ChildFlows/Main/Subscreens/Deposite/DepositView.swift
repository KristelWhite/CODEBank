//
//  DepositeView.swift
//  AnyApp
//
//  Created by Кристина Пастухова on 24.04.2024.
//

import UI
import UIKit
import AppIndependent

final class DepositView: BackgroundPrimary {
    enum Event {
    }
    var onEvent: ((Event) -> Void)?


    private let tableView = BaseTableView()
    private lazy var dataSource = DepositDataSource(tableView: tableView)


    override func setup() {
        super.setup()
        body().embed(in: self)
    }

    private func body() -> UIView {
        VStack {
            tableView
        }
        .layoutMargins(.make(hInsets: 16))
    }
}

extension DepositView: ConfigurableView {
    typealias Model = DepositViewProps

    func configure(with model: DepositViewProps) {
        dataSource.apply(sections: model.sections)
    }
}

