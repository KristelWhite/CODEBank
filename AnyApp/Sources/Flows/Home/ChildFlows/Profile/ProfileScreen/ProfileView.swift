import UI
import UIKit
import AppIndependent

final class ProfileView: BackgroundPrimary {

    var onLogout: VoidHandler?
    
    
    var settings: [Settings] = [.aboutApp, .theme, .support, .exit]
    var settingViews: [UIView] = []

    override func setup() {
        super.setup()
        confugureSettingsView()
        body().embed(in: self)
    }

    private func body() -> UIView {
        VStack {
            headerView()
            Spacer(.custom(length: 50))
            ForEach(collection: settingViews, alignment: .fill) { $0 }
            FlexibleSpacer()
            ButtonPrimary(title: "Разлогиниться")
                .onTap { [weak self] in
                    self?.onLogout?()
                }
        }.layoutMargins(.make(vInsets: 16, hInsets: 16))
    }
    
    private func headerView() -> UIView {
        VStack(alignment: .center) {
            Spacer(.px72)
            ImageView(image: Asset.title.image)
                .size(CGSize(width: 88, height: 88), priority: .required)
            Spacer(.px16)
            VStack(alignment: .center, spacing: 4) {
                Label(text: "bvz bzv bzvz bzvhbjbe", foregroundStyle: .textPrimary, fontStyle: .subtitle2)
                Label(text: "fknhfebhbfhbe", foregroundStyle: .textSecondary, fontStyle: .caption2)
            }
        }
    }
    private func confugureSettingsView() {
        settings.forEach { setting in
            let view = TemplateSettingsView()
            view.configure(with: setting.description )
            settingViews.append(view)
        }
    }
}
extension ProfileView: ConfigurableView {
    typealias Model = ProfileViewProps

    func configure(with model: ProfileViewProps) {
    
    }
    
    
}
