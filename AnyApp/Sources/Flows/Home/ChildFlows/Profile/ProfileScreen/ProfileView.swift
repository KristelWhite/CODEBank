import UI
import UIKit
import AppIndependent

final class ProfileView: BackgroundPrimary {

    enum Event {
        case loadData
        
    }

    var onEvent: ((Event) -> Void)?
    var scrollView: ScrollView = ScrollView(content: {UIView()})

    var onLogout: VoidHandler?
    var onAboutApp: VoidHandler?
    var onTheme: VoidHandler?
    var onSupport: VoidHandler?
    
    
    var settings: [Settings] = [.aboutApp, .theme, .support, .exit]
   
    enum Settings: CaseIterable {
        case aboutApp
        case theme
        case support
        case exit

    }
    private var refreshControl = UIRefreshControl()

    var props: Model?

    func handle(with settings: Settings) -> TemplateSettingsView.Props {
        switch settings {
        case .aboutApp:
            return .init(id: "1", title: "О приложении", image: Asset.settings.image, isAccesory: true) { [weak self] _ in
                self?.onAboutApp?()
            }
        case .theme:
            return .init(id: "2", title: "Тема приложения", image: Asset.moonStars.image, isAccesory: true) { [weak self] _ in
                self?.onTheme?()
                
            }
        case .support:
            return .init(id: "3", title: "Служба поддержки", image: Asset.phoneCall.image, isAccesory: false) { [weak self] _ in
                self?.onSupport?()
            }
        case .exit:
            return .init(id: "4", title: "Выход", image: Asset.accountOut.image, isAccesory: false) { [weak self] _ in
                self?.onLogout?()
            }
        }
    }
    override func setup() {
        super.setup()
        setupRefreshController()
        body().embed(in: self)
    }

    private func setupRefreshController() {
        refreshControl.attributedTitle = NSAttributedString(string: "Потяните, чтобы обновить")
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)

    }

    @objc func refreshData() {
        onEvent?(.loadData)
    }

    private func body() -> UIView {
        VStack {
            shimmerHeaderView()
            bottomView()
        }
        .layoutMargins(.make(vInsets: 16, hInsets: 16))
    }

    func shimmerHeaderView() -> UIView {
        VStack(alignment: .center) {
            Spacer(.px72)
            Shimmer()
                .size(CGSize(width: 88, height: 88), priority: .required)
            Spacer(.px16)
            VStack(alignment: .center, spacing: 4) {
                Shimmer()
                    .size(CGSize(width: 150, height: 22))
                Shimmer()
                    .size(CGSize(width: 100, height: 13))
            }
        }
    }

    private func body(with model: Model) -> UIView {
        scrollView = ScrollView {
            VStack {
                headerView(with: model)
                bottomView()
            }
            .layoutMargins(.make(vInsets: 16, hInsets: 16))
        }
        scrollView.refreshControl = refreshControl
        return scrollView

    }
    func bottomView() -> UIView {
        VStack {
            Spacer(.custom(length: 50))
            ForEach(collection: settings, alignment: .fill) { [weak self] in
                TemplateSettingsView()
                    .configured(with: (self?.handle(with: $0))!)
            }
            FlexibleSpacer()
        }
    }

    private func headerView(with model: Model) -> UIView {
        VStack(alignment: .center) {
            Spacer(.px72)
            ImageView(image: model.image)
                .size(CGSize(width: 88, height: 88), priority: .required)
                .cornerRadius(44)
                .clipsToBounds(true)

            Spacer(.px16)
            VStack(alignment: .center, spacing: 4) {
                Label(text: model.name, foregroundStyle: .textPrimary, fontStyle: .subtitle2)
                Label(text: model.phone.formatPhoneNumber(), foregroundStyle: .textSecondary, fontStyle: .caption2)
            }
        }
    }
}
extension ProfileView: ConfigurableView {
    typealias Model = ProfileViewProps

    func configure(with model: ProfileViewProps) {
        refreshControl.endRefreshing()
        self.props = model
        subviews.forEach { $0.removeFromSuperview() }
        body(with: model).embed(in: self)
    }
    
    
}
