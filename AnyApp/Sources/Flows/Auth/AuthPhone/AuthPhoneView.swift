import UI
import UIKit
import AppIndependent
import SnapKit

final class AuthPhoneView: BackgroundPrimary {
    
    var onAuth: VoidHandler?
    
    override func setup() {
        super.setup()
        body().embed(in: self)
        moveActionButtonWithKeyboard = true
        actionButton = ButtonPrimary(title: Entrance.enter)
            .height(52)
            .onTap { [weak self] in
                self?.onAuth?()
            }
    }
    
    private func body() -> UIView {
        VStack( alignment: .fill, spacing: 21) {
            ImageView(image: Asset.logo.image)
                .size(CGSize(width: 53, height: 59))
            PhoneTextField(placeholder: "Телефон")
                .height(52)
            FlexibleSpacer()
        }
        .layoutMargins(.all(16))
    }
}

final class PhoneTextField: TextField {
    
    private let paddingText = UIEdgeInsets(top: 14, left: 60, bottom: 14, right: 16)
    
    init(placeholder: String) {
        super.init(frame: .zero)
        configure(placeholder: placeholder)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
// MARK: - Override
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: paddingText)
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: paddingText)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: paddingText)
    }
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: UIEdgeInsets(top: 14, left: 24, bottom: 14, right: frame.width - 44))
    }
    private func configure(placeholder: String) {
        var iconView = UIImageView(image: Asset.phone.image)
        iconView.tintColor = Palette.Content.accentPrimary
        iconView.contentMode = .center
        leftView = iconView
        leftViewMode = .always
        keyboardType = .numberPad
        layer.cornerRadius = 20
        backgroundColor = Palette.Content.primary
        textColor = Palette.Text.primary
        tintColor = Palette.Content.accentPrimary
        font = Typography.body2?.font
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: Palette.Text.tertiary, NSAttributedString.Key.font: Typography.body2?.font])
    }
}
