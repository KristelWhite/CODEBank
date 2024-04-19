import Services
import Combine

final class AuthPhoneViewModel {

    enum Output {
        case otp(AuthOtpConfigModel)
    }

    enum Input {
        case phoneEntered(String)
    }

    var onOutput: ((Output) -> Void)?

    private let authRequestManager: AuthRequestManagerAbstract

    private var cancellables = Set<AnyCancellable>()

    init(authRequestManager: AuthRequestManagerAbstract) {
        self.authRequestManager = authRequestManager
    }

    func handle(_ input: Input) {
        switch input {
        case .phoneEntered(let phone):
            login(phone: phone)
        }
    }

    private func login(phone: String) {
        authRequestManager.authLogin(phone: phone)
            .sink(
                receiveCompletion: { _ in
                    // TODO: handle error
                },
                receiveValue: { [weak self] response in
                    let configModel = AuthOtpConfigModel(
                        otpId: response.otpId,
                        phone: phone,
                        otpCode: response.otpCode,
                        otpLength: response.otpLen
                    )
                    self?.onOutput?(.otp(configModel))
                }
            ).store(in: &cancellables)
    }
}
