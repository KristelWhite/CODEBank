//
//  DepositViewProps.swift
//  AnyApp
//
//  Created by Кристина Пастухова on 24.04.2024.
//

import Foundation

struct DepositViewProps {

    enum Section: Hashable {
        case date([Item])

        var items: [Item] {
            switch self {
            case .date(let items):
                return items
            }
        }
    }

    enum Item: Hashable {
        case shimmer(_ identifier: String = UUID().uuidString)
        case header(TemplateHeaderView.Props)
        case action(TemplateActionView.Props)
        case history(TemplateHistoryView.Props)
        case payment(TemplatePaymentView.Props)
    }

    let sections: [Section]
}

