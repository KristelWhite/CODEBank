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
            .sink { error in

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
            return .bottom([
                .header(.init(title: "title")),
                .history(.init(id: "1", title: "nsjfrf", date: "frnhn", value: "rsbjfhb", image: Asset.acado.image, isIncome: true))
                         ])
        case .action:
            break
        case .payment:
            break
        }
        return DepositViewProps.Section.top(.init())
    }

}



