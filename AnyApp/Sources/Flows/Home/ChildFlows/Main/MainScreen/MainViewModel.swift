import Services
import Combine
import UI

final class MainViewModel {

    typealias Props = MainViewProps

    enum Output {
        case content(Props)
    }

    enum Input {
        case loadData
    }

    var onOutput: ((Output) -> Void)?

    func handle(_ input: Input) {
        switch input {
        case .loadData:
            loadData()
        }
    }

    private func loadData() {
        onOutput?(.content(.init(sections: [
            .accounts(
                [.header(.init(title: "!Accounts"))] +
                (1...3).map { _ in .shimmer() }
            ),
            .deposits(
                [.header(.init(title: "!Deposits"))] +
                (1...3).map { _ in .shimmer() }
            )
        ])))

        // request:

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.onOutput?(.content(.init(sections: [
                .accounts([
                    .header(.init(title: "!Accounts")),
                    .account(.init(id: "1", title: "!Account 1", value: "762348724,00", currency: .ruble) { id in
                        SnackCenter.shared.showSnack(withProps: .init(message: "Account pressed with \(id)"))
                    }),
                    .card(.init(id: "1", title: "!Card 1", state: .closed, cardNumber: "9874", paymentSysem: .masterCard ) { id in
                        SnackCenter.shared.showSnack(withProps: .init(message: "Card pressed with \(id)"))
                    }),
                    .card(.init(id: "2", title: "!Card 2", state: .physical, cardNumber: "8950", paymentSysem: .visa, onTap: { id in
                        SnackCenter.shared.showSnack(withProps: .init(message: "Card pressed with \(id)"))
                    }))
                ]),
                .deposits([
                    .header(.init(title: "!Deposits")),
                    .deposit(.init(id: "1", title: "!Deposit 1", rate: "3 %", date: "до 31.09.2025", value: "687374,00", currency: .ruble)),
                    .deposit(.init(id: "2", title: "!Deposit 1", rate: "3 %", date: "до 31.09.2025", value: "687374,00", currency: .dollar)),
                    .deposit(.init(id: "3", title: "!Deposit 1", rate: "3 %", date: "до 31.09.2025", value: "687374,00", currency: .euro))
                ])
            ])))
        }
    }
}

