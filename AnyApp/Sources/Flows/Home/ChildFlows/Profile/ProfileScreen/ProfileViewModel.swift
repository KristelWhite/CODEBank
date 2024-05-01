import Services
import Combine
import UI

final class ProfileViewModel {

    typealias Props = ProfileViewProps

    enum Output {
        case content(Props)
        case error(ErrorView.Props)
        case removeState
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
            appSession.handle(.logout(.init(needFlush: true, alert: .snack(message: Profile.logout))))
        case .loadData:
            loadData()
        }
    }

    func loadData() {
        coreRequestManager.profile()
                .sink(receiveCompletion: { [weak self] error in
                    guard case let .failure(error) = error else { return }
                    let errorProps = ErrorUIHandler.handle(error) { [weak self] in
                        self?.onOutput?(.removeState)
                        self?.loadData()
                    }
                    self?.onOutput?(.error(errorProps))
                    print(error.appError.localizedDescription)
            }, receiveValue: { [weak self] response in
                self?.onOutput?(.content(.init(name: "\(response.firstName) \(response.middleName)  \(response.lastName)", phone: response.phone)))
            })
            .store(in: &cancellables)
    }
}
