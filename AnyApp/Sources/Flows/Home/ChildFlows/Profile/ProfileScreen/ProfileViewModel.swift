import Services
import Combine

final class ProfileViewModel {

    typealias Props = ProfileViewProps

    enum Output {
        case content(Props)
    }

    enum Input {
        case logout
        case loadData
    }
    var onOutput: ((Output) -> Void)?

    private let appSession: AppSession

    private let coreRequestManager: CoreRequestManagerAbstract

    private var cancellables = Set<AnyCancellable>()

    init(
        appSession: AppSession,
        coreRequestManager: CoreRequestManagerAbstract
    ) {
        self.appSession = appSession
        self.coreRequestManager = coreRequestManager
    }

    func handle(_ input: Input) {
        switch input {
        case .logout:
            appSession.handle(.logout(.init(needFlush: true, alert: .snack(message: "Вы разлогинились"))))
        case .loadData:
            loadData()
        }
    }

    func loadData() {
        coreRequestManager.profile()
            .sink { _ in

            } receiveValue: { [weak self] response in
                self?.onOutput?(.content(.init(name: "\(response.firstName) \(response.middleName)  \(response.lastName)", phone: response.phone)))
            }
            .store(in: &cancellables)
    }
}
