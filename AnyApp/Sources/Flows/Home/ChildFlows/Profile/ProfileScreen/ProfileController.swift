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
            self?.viewModel.handle(.logout)
        }
        rootView.onAboutApp = { [weak self] in
            self?.onEvent?(.aboutApp)
        }
        rootView.onTheme = { [weak self] in
            self?.onEvent?(.onTheme)
        }
        
    }
}
