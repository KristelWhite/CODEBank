import UI
import UIKit
import AppIndependent

final class ProfileView: BackgroundPrimary {

    var onLogout: VoidHandler?
    var onAboutApp: VoidHandler?
    var onTheme: VoidHandler?
    
    
    var settings: [Settings] = [.aboutApp, .theme, .support, .exit]
   
    enum Settings: CaseIterable {
        case aboutApp
        case theme
        case support
        case exit
    }

    func handle(with settings: Settings) -> TemplateSettingsView.Props {
        switch settings {
        case .aboutApp:
            return .init(id: "1", title: "О приложении", image: Asset.settings.image, isAccesory: true){ [weak self] _ in
                self?.onAboutApp?()
            }
        case .theme:
            return .init(id: "2", title: "Тема приложения", image: Asset.moonStars.image, isAccesory: true){ [weak self] _ in
                self?.onTheme?()
                
            }
        case .support:
            return .init(id: "3", title: "Служба поддержки", image: Asset.phoneCall.image, isAccesory: false)
        case .exit:
            return .init(id: "4", title: "Выход", image: Asset.accountOut.image, isAccesory: false){ [weak self] _ in
                self?.onLogout?()
            }
        }
    }
    override func setup() {
        super.setup()
        body().embed(in: self)
    }

    private func body() -> UIView {
        VStack {
            headerView()
            Spacer(.custom(length: 50))
            ForEach(collection: settings, alignment: .fill) { [weak self] in
                TemplateSettingsView()
                    .configured(with: (self?.handle(with: $0))!)
            }
            FlexibleSpacer()
        }
        .layoutMargins(.make(vInsets: 16, hInsets: 16))
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
}
extension ProfileView: ConfigurableView {
    typealias Model = ProfileViewProps

    func configure(with model: ProfileViewProps) {
    
    }
    
    
}
