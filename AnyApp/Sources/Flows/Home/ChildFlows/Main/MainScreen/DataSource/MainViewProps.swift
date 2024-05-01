import Foundation

struct MainViewProps {

    enum Section: Hashable {
        case accounts([Item])
        case deposits([Item])

        var items: [Item] {
            switch self {
            case .accounts(let items),
                    .deposits(let items):
                return items
            }
        }
    }

    enum Item: Hashable {
        case shimmerAccount(_ identifier: String = UUID().uuidString)
        case shimmerHeader(_ identifier: String = UUID().uuidString)
        case shimmerDeposit(_ identifier: String = UUID().uuidString)
        case shimmerCard(_ identifier: String = UUID().uuidString)
        case header(HeaderViewCell.Props)
        case account(AccountViewCell.Props)
        case card(CardViewCell.Props)
        case deposit(DepositViewCell.Props)
    }

    let sections: [Section]
}
