import UI
import UIKit
import AppIndependent

final class AuthOtpController: TemplateViewController<AuthOtpView>, NavigationBarAlwaysVisible {

    typealias ViewModel = AuthOtpViewModel

    enum Event {
        case userLoggedIn

    }

    var onEvent: ((Event) -> Void)?

    private var viewModel: ViewModel!

    convenience init(viewModel: ViewModel) {
        self.init()
        self.viewModel = viewModel
    }

    override func setup() {
        super.setup()
        setupBindings()
    }

    private func setupBindings() {
        rootView.onOtpFilled = { [weak self] code in
            self?.viewModel.handle(.otpEntered(code))
        }
        rootView.onOutput = {[weak self] event in
            switch event {
            case .refreshOtp:
                self?.viewModel.handle(.refreshOtp)

            }
        }

        viewModel.onOutput = { [weak self] output in
            switch output {
            case .userLoggedIn:
                self?.onEvent?(.userLoggedIn)
            case .closeSession:
                self?.showExitConfirmation()
            case .wrongOtp(let count):
                self?.rootView.handle(input: .errorCondition(count))
            }
        }
    }
}

extension AuthOtpController {
    func showExitConfirmation() {
        let alertController = UIAlertController(title: Common.Error.wrongFiveTimes, message: Common.Error.finishSession, preferredStyle: .alert)
        let exitAction = UIAlertAction(title: Common.quit1, style: .cancel) { [weak self] action in
            self?.viewModel.handle(.closeSession)
        }
        alertController.addAction(exitAction)
        present(alertController, animated: true, completion: nil)
    }
}
