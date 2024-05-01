import UI
import UIKit

final class ProfileController: TemplateViewController<ProfileView> {

    typealias ViewModel = ProfileViewModel
    
    enum Event {
        case aboutApp
        case onTheme
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
        viewModel.handle(.loadData)
    }

    private func setupBindings() {
        rootView.onLogout = { [weak self] in
            self?.showExitConfirmation()
        }
        rootView.onAboutApp = { [weak self] in
            self?.onEvent?(.aboutApp)
        }
        rootView.onTheme = { [weak self] in
            self?.onEvent?(.onTheme)
        }
        rootView.onSupport = { [weak self] in
            self?.showCallConfirmation()
        }
        rootView.onEvent = { [weak self] event in
            switch event {
            case .loadData:
                self?.viewModel.handle(.loadData)
            }

        }
        viewModel.onOutput = { [weak self] output in
            switch output {
            case .content(let props):
                self?.rootView.configured(with: props)
            case .error(let errorProps):
                self?.setAdditionState(.error(errorProps))
            case .removeState:
                self?.removeAdditionalState()
            }
        }

    }
}
// MARK: - Support Call
extension ProfileController {
    
    func showCallConfirmation() {
        let phone = Profile.phone
        let actionSheet = UIAlertController(title: Profile.call, message: nil, preferredStyle: .actionSheet)
        let callAction = UIAlertAction(title: "\(phone)", style: .default) { (action) in
            self.makeCall(to: phone)
        }
        let cancelAction = UIAlertAction(title: Common.cancel, style: .cancel)
//        callAction.setValue( UIColor.black, forKey: "titleTextColor")
//        cancelAction.setValue( UIColor.black, forKey: "titleTextColor")
        
        actionSheet.addAction(callAction)
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true)
    }
    
    func makeCall(to phone: String) {
        if let phoneURL = URL(string: "tel://\(phone)") {
            if UIApplication.shared.canOpenURL(phoneURL) {
                UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
            }
        }
    }
}
// MARK: - Exit Alert
extension ProfileController {
    
    func showExitConfirmation() {
        let alertController = UIAlertController(title: Profile.exit, message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: Common.cancel, style: .cancel) { action in
        }

        let exitAction = UIAlertAction(title: Common.quit, style: .destructive) { [weak self] action in
            self?.viewModel.handle(.logout)
        }
    
        alertController.addAction(cancelAction)
        alertController.addAction(exitAction)
        
        present(alertController, animated: true, completion: nil)
    }

    
}
