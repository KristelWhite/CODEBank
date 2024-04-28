//
//  DepositeViewModel.swift
//  AnyApp
//
//  Created by Кристина Пастухова on 24.04.2024.
//

import Services
import Combine
import UI

final class DepositViewModel { 

    typealias Props = DepositViewProps

    enum Output {
        case content(Props)
        case error(ErrorView.Props)
        case removeState
    }

    enum Input {
        case loadData

    }

    var onOutput: ((Output) -> Void)?

    var response: AccountInfoResponse?
    var selectedTab: SwitchView.State = .history


    private var cancellables = Set<AnyCancellable>()

    private var id: Int
    private var coreRequestManager: CoreRequestManagerAbstract

    init(id: Int, coreRequestManager: CoreRequestManagerAbstract) {
        self.id = id
        self.coreRequestManager = coreRequestManager
    }

    func handle(_ input: Input) {
        switch input {
        case .loadData:
            loadData()
        }
    }
    private func loadData() {
        print(id)
        coreRequestManager.accountInfo(accountId: id)
            .sink { [weak self] error in
                guard case let .failure(error) = error else { return }
                let errorProps = ErrorUIHandler.handle(error) { [weak self] in
                    self?.onOutput?(.removeState)
                    self?.loadData()
                }
                self?.onOutput?(.error(errorProps))
                print(error.appError.localizedDescription)
            } receiveValue: { [weak self] response in
                print(" responce \(response)")
                self?.response = response
                self?.handleReceivedData(with: response)
            }.store(in: &cancellables)
    }

    func changeSelectedTab(selectedTab: SwitchView.State) {
        self.selectedTab = selectedTab
        guard let response = response else { return }
        handleReceivedData(with: response, selectedTab: selectedTab)
    }

    func handleReceivedData(with response: AccountInfoResponse, selectedTab: SwitchView.State = .history)  {
        var section: [Props.Section] = []
        var items: [Props.Item] = []
        items.append(.depositHeader(.init(id: response.accountId, name: "Счет расчетный", cardNumber: response.number, currency: .ruble, value: response.balance)))
        items.append(.switchView(.init(state: selectedTab, onTap: {[weak self] selectedTab in
            self?.changeSelectedTab(selectedTab: selectedTab)
        })))
        section.append(.top(items))
        section.append(bottomSection(selectedTab: selectedTab ))
        onOutput?(.content(.init(sections: section)))
    }

    private func bottomSection(selectedTab: SwitchView.State) -> DepositViewProps.Section {
        switch selectedTab {
        case .history:
            return .bottom(accountMocks)
        case .action:
            return .bottom([
                .action(.init(id: "0", title: "Привязанные карты", image: Asset.cardWhite.image, isAccesory: true)),
                .action(.init(id: "1", title: "Переименовать счет", image: Asset.rename.image, isAccesory: false)),
                .action(.init(id: "2", title: "Реквизиты счета", image: Asset.requisites.image, isAccesory: false)),
                .action(.init(id: "3", title: "Закрыть счет", image: Asset.bankAccount.image, isAccesory: false))])
        case .payment:
            return .bottom([
                .payment(.init(id: "0", title: "Мобильная связь", image: Asset._1Mobile.image)),
                .payment(.init(id: "1", title: "ЖКХ", image: Asset._1Jkh.image)),
                .payment(.init(id: "2", title: "Интернет", image: Asset._1Internet.image))])
        }
    }
}

//MARK: - MOCKS
extension DepositViewModel {
    var accountMocks: [Props.Item] {[
        .header(.init(title: "Июнь 2021")),
        .history(.init(id: "0", title: "Оплата OOO \"Янтарь энерго\" ", date: "25 июня, 18:52", value: "-1 500,00", image: Asset.yantar.image , isIncome: false)),
        .history(.init(id: "1", title: "Зачисление зарплаты", date: "25 июня, 17:38", value: "+ 15 000,00", image: Asset._2CardPay.image , isIncome: true)),
        .history(.init(id: "2", title: "Первод Александру Олеговичу С.", date: "25 июня, 15:13", value: "-6 000,00", image: Asset._2CardPay.image , isIncome: false)),
        .history(.init(id: "3", title: "Оплата Транспорта", date: "25 июня, 12:01", value: "-33,00", image: Asset._2AccountPay.image , isIncome: false)),
        .history(.init(id: "4", title: "Первод Ольге Владимировне Т.", date: "25 июня, 9:47", value: "-15 000,00", image: Asset._2CardPay.image , isIncome: false)),
    ]}
}


