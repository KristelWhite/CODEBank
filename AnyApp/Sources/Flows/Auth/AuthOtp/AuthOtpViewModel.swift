import Services
import Combine

final class AuthOtpViewModel {

    typealias ConfigModel = AuthOtpConfigModel

    enum Input {
        case otpEntered(String)
        case refreshOtp
    }

    enum Output {
        case userLoggedIn
    }

    var onOutput: ((Output) -> Void)?

    private var configModel: ConfigModel
    private let authRequestManager: AuthRequestManagerAbstract
    private let appSession: AppSession

    private var cancellables = Set<AnyCancellable>()

    init(
        configModel: ConfigModel,
        authRequestManager: AuthRequestManagerAbstract,
        appSession: AppSession
    ) {
        self.configModel = configModel
        self.authRequestManager = authRequestManager
        self.appSession = appSession
    }

    func handle(_ input: Input) {
        switch input {
        case .otpEntered(let code):
            confirmOtp(code: code)
        case .refreshOtp:
            login()
        }
    }

    private func login() {
        authRequestManager.authLogin(phone: configModel.phone)
            .sink(
                receiveCompletion: { [weak self] error in
                    guard case let .failure(error) = error else { return }
                    //change on Snack
                    print(error.appError.localizedDescription)
                },
                receiveValue: { [weak self] response in
                    self?.configModel = AuthOtpConfigModel(
                        otpId: response.otpId,
                        phone: self?.configModel.phone ?? "",
                        otpCode: response.otpCode,
                        otpLength: response.otpLen
                    )
                }
            ).store(in: &cancellables)

    }

    private func confirmOtp(code: String) {
        authRequestManager.authConfirm(otpId: configModel.otpId, phone: configModel.phone, otpCode: code)
            .sink(
                receiveCompletion: { _ in
                    // handle error
                }, receiveValue: { [weak self] response in
                    self?.appSession.handle(.updateTokens(
                        accessToken: response.guestToken,
                        refreshToken: ""
                    ))
                    //local cheak
                    if code == self?.configModel.otpCode {
                        self?.onOutput?(.userLoggedIn)
                    }
                }
            ).store(in: &cancellables)
    }

}
