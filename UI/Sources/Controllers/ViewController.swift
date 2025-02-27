import UIKit
import Combine
import AppIndependent

// swiftlint:disable:next final_class
open class ViewController: BaseController, Themeable {

    public enum AdditionalState {
        case none
        case loading
        case error(ErrorView.Props)
    }

    private(set) var backgroundStyle: BackgroundStyle?

    private let loadingView = UIView()
    private let errorView = ErrorView()
    private let spinner = LargeSpinner()
    private lazy var loadView = BackgroundView {
        spinner
    }

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self is NavigationBarAlwaysVisible {
            navigationController?.setNavigationBarHidden(false, animated: animated)
        }
        if self is NavigationBarAlwaysHidden {
            navigationController?.setNavigationBarHidden(true, animated: animated)
        }
    }

    override open func setup() {
        super.setup()
        subscribeOnThemeChanges()
    }

    open func updateAppearance() {
        if let backgroundStyle {
            view.backgroundColor(backgroundStyle.color)
        }
    }

    open func backgroundStyle(_ style: BackgroundStyle) {
        self.backgroundStyle = style
        updateAppearance()
    }

    open func navigationBarStyle(_ style: NavigationBar.Style) {
        (navigationController?.navigationBar as? NavigationBar)?.style(style)
    }

    public func setAdditionState(_ state: AdditionalState) {
        loadingView.removeFromSuperview()
        errorView.removeFromSuperview()

        switch state {
        case .none:
            break
        case .loading:
            break
        case .error(let props):
            view.embed(subview: errorView)
            errorView.configure(with: props)
        }
    }

    public func removeAdditionalState() {
        setAdditionState(.none)
    }
}
