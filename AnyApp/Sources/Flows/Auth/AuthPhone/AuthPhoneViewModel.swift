import Services
import Core
import UI
import AppIndependent
import Combine

final class AuthPhoneViewModel {

    enum Output {
        case otp(AuthOtpConfigModel)
        case error(ErrorView.Props)
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
                receiveCompletion: { [weak self] error in
                    guard case let .failure(error) = error else { return }
                    let errorProps = ErrorUIHandler.handle(error, onTap: {})
                    self?.onOutput?(.error(errorProps))
                    print(error.appError.localizedDescription)
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

public struct ErrorUIHandler {
    static func handle(_ error: ErrorWithContext, onTap: @escaping VoidHandler) -> ErrorView.Props {
        switch error.appError.kind {
        case .network:
            return ErrorView.Props(
                title: "",
                message: "efff",
                image: Asset.eye.image,
                buttonTitle: "update",
                onTap: onTap
            )
        default:
            return ErrorView.Props(
                title: "dfef",
                message: "efff",
                image: Asset.eye.image,
                buttonTitle: "update",
                onTap: onTap
            )
            break
        }
    }
}
