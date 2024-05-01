//
//  CardViewModel.swift
//  AnyApp
//
//  Created by Кристина Пастухова on 01.05.2024.
//

import Services
import Combine
import UI

final class CardInfoViewModel {

    typealias Props = CardViewProps

    enum Output {
        case content(Props)
        case error(ErrorView.Props)
        case removeState
    }

    enum Input {
        case loadData

    }

    var onOutput: ((Output) -> Void)?

    private var response: CardInfoResponse?
    private var selectedTab: SwitchView.State?
    private var cardId: String
    private var coreRequestManager: CoreRequestManagerAbstract

    private var cancellables = Set<AnyCancellable>()

    init(cardId: String, coreRequestManager: CoreRequestManagerAbstract) {
        self.cardId = cardId
        self.coreRequestManager = coreRequestManager
    }

    func handle(_ input: Input) {
        switch input {
        case .loadData:
            loadData()
        }
    }
    private func loadData() {
        addShimmer()
        coreRequestManager.cardInfo(cardId: cardId)
            .sink { [weak self] error in
                guard case let .failure(error) = error else { return }
                let errorProps = ErrorUIHandler.handle(error) { [weak self] in
                    self?.onOutput?(.removeState)
                    self?.loadData()
                }
                self?.onOutput?(.error(errorProps))
                print(error.appError.localizedDescription)
            } receiveValue: { [weak self] response in
                self?.response = response
                self?.handleReceivedData(with: response, selectedTab: self?.selectedTab ?? .history)
            }.store(in: &cancellables)
    }

    private func addShimmer() {
        onOutput?(.content(.init(sections: [
            .top([
                .shimmerCardHeader(),
                .shimerSwitch() ] ),
            .bottom(
                (0...6).map { _ in .shimmerHistory() }
                )])))
    }

    private func changeSelectedTab(selectedTab: SwitchView.State) {
        self.selectedTab = selectedTab
        guard let response = response else { return }
        handleReceivedData(with: response, selectedTab: selectedTab)
    }

    private func handleReceivedData(with response: CardInfoResponse, selectedTab: SwitchView.State ) {
        var section: [Props.Section] = []
        var items: [Props.Item] = []
        items.append(.cardHeader(.init(id: response.id, name: response.name, cardNumber: response.number, currency: .rub, value: 234543, date: response.expiredAt, paymentSystem: response.paymentSystem)))
        items.append(.switchView(.init(state: selectedTab, onTap: {[weak self] selectedTab in
            self?.changeSelectedTab(selectedTab: selectedTab)
        })))
        section.append(.top(items))
        section.append(.bottom(bottomSection(selectedTab: selectedTab)))
        onOutput?(.content(.init(sections: section)))
    }

    private func bottomSection(selectedTab: SwitchView.State) -> [Props.Item] {
        switch selectedTab {
        case .history:
            return accountMocks
        case .action:
            return [
                .action(.init(id: "0", title: Main.activeCards, image: Asset.cardWhite.image, isAccesory: true) { _ in
                    SnackCenter.shared.showSnack(withProps: .init(message: Common.duringDevelopment))
                }),
                .action(.init(id: "1", title: Main.renameDeposit, image: Asset.rename.image, isAccesory: false) { _ in
                    SnackCenter.shared.showSnack(withProps: .init(message: Common.duringDevelopment))
                }),
                .action(.init(id: "2", title: Main.depositInfo, image: Asset.requisites.image, isAccesory: false) { _ in
                    SnackCenter.shared.showSnack(withProps: .init(message: Common.duringDevelopment))
                }),
                .action(.init(id: "3", title: Main.closeDeposit, image: Asset.bankAccount.image, isAccesory: false) { _ in
                    SnackCenter.shared.showSnack(withProps: .init(message: Common.duringDevelopment))
                })
                ]
        case .payment:
            return [
                .payment(.init(id: "0", title: Main.mobile, image: Asset._1Mobile.image) { _ in
                    SnackCenter.shared.showSnack(withProps: .init(message: Common.duringDevelopment))
                }),
                .payment(.init(id: "1", title: Main.houseHold, image: Asset._1Jkh.image) { _ in
                    SnackCenter.shared.showSnack(withProps: .init(message: Common.duringDevelopment))
                }),
                .payment(.init(id: "2", title: Main.intermet, image: Asset._1Internet.image) { _ in
                    SnackCenter.shared.showSnack(withProps: .init(message: Common.duringDevelopment))
                })]
        }
    }
}

// MARK: - MOCKS
extension CardInfoViewModel {
    var accountMocks: [Props.Item] {[
        .header(.init(title: "Июнь 2021")),
        .history(.init(id: "0", title: "Оплата OOO \"Янтарь энерго\" ", date: "25 июня, 18:52", value: "-1 500,00 ₽", image: Asset.yantar.image, isIncome: false)),
        .history(.init(id: "1", title: "Зачисление зарплаты", date: "25 июня, 17:38", value: "+ 15 000,00 ₽", image: Asset._2CardPay.image, isIncome: true)),
        .history(.init(id: "2", title: "Первод Александру Олеговичу С.", date: "25 июня, 15:13", value: "-6 000,00 ₽", image: Asset._2CardPay.image, isIncome: false)),
        .history(.init(id: "3", title: "Оплата Транспорта", date: "25 июня, 12:01", value: "-33,00 ₽", image: Asset._2AccountPay.image, isIncome: false)),
        .history(.init(id: "4", title: "Первод Ольге Владимировне Т.", date: "25 июня, 9:47", value: "-15 000,00 ₽", image: Asset._2CardPay.image, isIncome: false))
    ]}
}
