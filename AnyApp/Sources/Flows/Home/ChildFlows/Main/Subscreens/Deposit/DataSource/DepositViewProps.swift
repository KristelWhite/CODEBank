//
//  DepositViewProps.swift
//  AnyApp
//
//  Created by Кристина Пастухова on 24.04.2024.
//

import Foundation

struct DepositViewProps {

    enum Section: Hashable {
        case top([Item])
        case bottom([Item])

        var items: [Item] {
            switch self {
            case .top(let items), .bottom(let items):
                return items
            }
        }
    }

    enum Item: Hashable {
        case shimerSwitch(_ identifier: String = UUID().uuidString)
        case shimmerDepositHeader(_ identifier: String = UUID().uuidString)
        case shimmerAction(_ identifier: String = UUID().uuidString)
        case shimmerPayment(_ identifier: String = UUID().uuidString)
        case shimmerHistory(_ identifier: String = UUID().uuidString)
        case shimmerHeader(_ identifier: String = UUID().uuidString)
        case header(HeaderViewCell.Props)
        case action(ActionViewCell.Props)
        case history(TransactionViewCell.Props)
        case payment(PaymentViewCell.Props)
        case switchView(SwitchView.Props)
        case depositHeader(HeaderDepositView.Props)
    }
    let sections: [Section]
}
