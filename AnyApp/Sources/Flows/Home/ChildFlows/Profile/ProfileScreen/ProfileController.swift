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
    }
}
// MARK: - Support Call
extension ProfileController {
    
    func showCallConfirmation() {
        let phone = "8 (800) 000-00-00"
        let actionSheet = UIAlertController(title: "Звонок в службу поддержки", message: nil, preferredStyle: .actionSheet)
        let callAction = UIAlertAction(title: "\(phone)", style: .default) { (action) in
            self.makeCall(to: phone)
        }
        let cancelAction = UIAlertAction(title: "Отменить", style: .cancel)
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
        let alertController = UIAlertController(title: "Вы точно хотите выйти?", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { action in
        }

        let exitAction = UIAlertAction(title: "Выйти", style: .destructive) { [weak self] action in
            self?.viewModel.handle(.logout)
        }
    
        alertController.addAction(cancelAction)
        alertController.addAction(exitAction)
        
        present(alertController, animated: true, completion: nil)
    }

    
}
