import UI
import UIKit
import AppIndependent

final class AuthPhoneController: TemplateViewController<AuthPhoneView> {

    typealias ViewModel = AuthPhoneViewModel

    enum Event {
        case otp(AuthOtpConfigModel)
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
        rootView.onAuth = { [weak self] phone in
            self?.rootView.handle(input: .startLoading)
            self?.viewModel.handle(.phoneEntered(phone))
        }

        viewModel.onOutput = { [weak self] output in
            switch output {
            case .otp(let configModel):
                self?.onEvent?(.otp(configModel))
                self?.rootView.handle(input: .finishLoading)
            }
        }
    }
}
