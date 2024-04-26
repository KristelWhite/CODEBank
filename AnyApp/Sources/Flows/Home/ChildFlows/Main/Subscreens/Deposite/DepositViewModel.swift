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
        case profileInfo(DepositView.Props)
//        case selectDeposit(with: Int)
    }

    enum Input {
        case loadData
    }

    var onOutput: ((Output) -> Void)?

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
        loadProfileInfo()
        loadHistory()


    }
    private func loadProfileInfo() {
        print(id)
        coreRequestManager.accountInfo(accountId: id)
            .sink { error in

            } receiveValue: { [weak self] request in
                print(request)
                self?.onOutput?(.profileInfo(.init(id: request.accountId, name: "Счет расчетный", cardNumber: request.number, currency: .ruble, value: request.balance)))
            }.store(in: &cancellables)
    }
    private func loadHistory() {

    }
}


