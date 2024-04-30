import Services
import Combine
import UI

final class MainViewModel {

    typealias Props = MainViewProps

    enum Output {
        case content(Props)
        case selectCard(with: String)
        case selectAccount(with: Int)
        case error(ErrorView.Props)
        case removeState
        case loader
        case showActionButton
    }

    enum Input {
        case loadData
    }

    var onOutput: ((Output) -> Void)?

    private let coreRequestManager: CoreRequestManagerAbstract

    private var cancellables = Set<AnyCancellable>()

    init(
        coreRequestManager: CoreRequestManagerAbstract
    ) {
        self.coreRequestManager = coreRequestManager
    }


    func handle(_ input: Input) {
        switch input {
        case .loadData:
            loadData()
        }
    }

    private func loadData() {
        onOutput?(.content(.init(sections: [
            .accounts(
                [.shimmerHeader()] + [.shimmerAccount()] +
                (1...3).map { _ in .shimmerCard() }
            ),
            .deposits(
                [.shimmerHeader()] +
                (1...3).map { _ in .shimmerDeposit()}
            )
        ])))

//         request:

        let accountsPublisher = coreRequestManager.accountsList()
            .eraseToAnyPublisher()
        let depositsPublisher = coreRequestManager.depositsList()
            .eraseToAnyPublisher()

        Publishers.CombineLatest(accountsPublisher, depositsPublisher)
            .sink(receiveCompletion: { [weak self] error in
                guard case let .failure(error) = error else { return }
                let errorProps = ErrorUIHandler.handle(error) { [weak self] in
                    self?.onOutput?(.removeState)
                    self?.loadData()
                }
                self?.onOutput?(.error(errorProps))
                print(error.appError.localizedDescription)
            }, receiveValue: { [weak self] accountsResponse, depositsResponse in
                print("Аккаунты: \(accountsResponse)")
                print("Депозиты: \(depositsResponse)")
                self?.handleReceivedData(accounts: accountsResponse, deposits: depositsResponse)
            })
            .store(in: &cancellables)


//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
//            self?.onOutput?(.content(.init(sections: [
//                .accounts([
//                    .header(.init(title: "!Accounts")),
//                    .account(.init(id: 1, title: "!Account 1", value: "762348724,00", currency: .ruble) { id in
//                        SnackCenter.shared.showSnack(withProps: .init(message: "Account pressed with \(id)"))
//
//
//                    }),
//                    .card(.init(id: "1", title: "!Card 1", state: .closed, cardNumber: "9874", paymentSysem: .masterCard ) { id in
//                        SnackCenter.shared.showSnack(withProps: .init(message: "Card pressed with \(id)"))
//                    }),
//                    .card(.init(id: "2", title: "!Card 2", state: .physical, cardNumber: "8950", paymentSysem: .visa, onTap: { id in
//                        SnackCenter.shared.showSnack(withProps: .init(message: "Card pressed with \(id)"))
//                    }))
//                ]),
//                .deposits([
//                    .header(.init(title: "!Deposits")),
//                    .deposit(.init(id: "1", title: "!Deposit 1", rate: "3 %", date: "до 31.09.2025", value: "687374,00", currency: .ruble)),
//                    .deposit(.init(id: "2", title: "!Deposit 1", rate: "3 %", date: "до 31.09.2025", value: "687374,00", currency: .dollar)),
//                    .deposit(.init(id: "3", title: "!Deposit 1", rate: "3 %", date: "до 31.09.2025", value: "687374,00", currency: .euro))
//                ])
//            ])))
//        }
    }

    private func handleReceivedData(accounts: AccountsListResponse, deposits: DepositsListResponse) {
        var sections: [Props.Section] = []
        var accountItems: [Props.Item] = []
        var depositItems: [Props.Item] = []
        accounts.accounts.forEach {
            accountItems.append(.header(.init(title: "Счета")))
            accountItems.append(.account(.init(id: $0.accountId, title: "Расчетный счет", value: $0.balance, currency: $0.currency) { id in
                guard let account = accounts.accounts.first(where: { $0.accountId == id }) else { return }
                self.onOutput?(.selectAccount(with: id))
            }))
            if let cards = $0.cards {
                cards.forEach {
                    let state: CardState = $0.status == .deactivated ? .closed : (($0.cardType == .digital) ? .digital : .physical)
                    accountItems.append(.card(.init(id: $0.id.uuidString, title: $0.name, state: state, cardNumber: "123456789098", paymentSystem: $0.paymentSystem, onTap: { id in
                        guard let card = cards.first(where: { $0.id.uuidString == id }) else { return }
                        self.onOutput?(.selectCard(with: id))
                    })))
                }
            }
        }
        sections.append(.accounts(accountItems))

        depositItems.append(.header(.init(title: "Вклады")))
        deposits.deposits.forEach {
            depositItems.append(.deposit(.init(id: $0.depositId, title: $0.name ?? "Безымянный", rate: "Ставка 7.65%", date: "до 31.08.2024", value: $0.balance, currency: $0.currency, onTap: { _ in
                SnackCenter.shared.showSnack(withProps: .init(message: "Данный функционал будет добавлен позже"))
            })))
        }

        sections.append(.deposits(depositItems))
        self.onOutput?(.content(.init(sections: sections)))
        self.onOutput?(.showActionButton)

    }
}


// MARK: - Mocks

extension MainViewModel {
    var accountMocks: [Props.Item] {
        []
    }
}

struct MainResponse {
    struct Account {
        let id: String
        let name: String
        let cards: [Card]
    }
    
    struct Card {
        let id: String
    }
    
    let accounts: [Account]
}


let mainResponse = MainResponse(accounts: [
    .init(id: "1", name: "name", cards: [
        .init(id: "1"),
        .init(id: "2")
    ])
])
