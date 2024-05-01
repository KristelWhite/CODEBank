import UI
import UIKit
import AppIndependent
import SnapKit

final class AuthPhoneView: BackgroundPrimary {
    enum Input {
        case startLoading
        case finishLoading
    }

    var onAuth: StringHandler?

    private var phoneTextField = TextField(foregroundStyle: .textPrimary, fontStyle: .body2, placeholderForegroundStyle: .textTertiary, placeholderFontStyle: .body2)
    private var image = ImageView(image: Asset.phone.image)
        .foregroundStyle(.contentAccentPrimary)
    private var spinner = MediumSpinner()
        .foregroundStyle(.contentAccentPrimary)

    override func setup() {
        super.setup()
        configureTextField()
        body().embed(in: self)
        moveActionButtonWithKeyboard = true
        actionButton = ButtonPrimary(title: Entrance.enter)
            .onTap { [weak self] in
                guard let self = self, let phone = self.phoneTextField.text else { return }
                if phone.count == 18 {
                    self.onAuth?(phone)
                } else {
                    self.snackServerError(message: Common.Error.cheakNumber)
                }
            }
    }

    func handle(input: Input) {
        switch input {
        case .startLoading:
            spinner.start()
        case .finishLoading:
            spinner.stop()
        }
    }

    private func body() -> UIView {
        VStack {
            Spacer(.px16)
            ImageView(image: Asset.logo.image)
                .size(CGSize(width: 53, height: 59))
                .foregroundStyle(.contentAccentTertiary)
            Spacer(.px20)
            BackgroundView {
                HStack(alignment: .center) {
                    Spacer(.px24)
                    image
                        .size(CGSize(width: 24, height: 24))
                    Spacer(.px16)
                    phoneTextField
                        .tintColor(UIColor {_ in
                            Palette.Content.accentPrimary})
                        .placeholder(Entrance.phone)
                        .keyboardType(.numberPad)
                    FlexibleSpacer()
                    spinner
                    Spacer(.px16)
                }
            }
            .backgroundStyle(.contentSecondary)
            .cornerRadius(20)
            .height(52)
            FlexibleSpacer()
        }
        .layoutMargins(.make(hInsets: 16))
    }

    private func configureTextField() {
        phoneTextField.delegate = self
    }

    private func snackServerError(message: String) {
        SnackCenter.shared.showSnack(withProps: .init(message: message, style: .error))
        self.phoneTextField.foregroundStyle(.indicatorContentError)
        self.image.foregroundStyle(.indicatorContentError)
        Timer.scheduledTimer(
            timeInterval: 5,
            target: self,
            selector: #selector(self.changeColor),
            userInfo: nil,
            repeats: false
        )
    }

    @objc private func changeColor() {
        phoneTextField.foregroundStyle(.textPrimary)
        image.foregroundStyle(.contentAccentPrimary)
    }
}
// MARK: - UITextFieldDelegate

extension AuthPhoneView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let fullString = (textField.text ?? "") as NSString
        let updatedString = fullString.replacingCharacters(in: range, with: string)

        let digitsOnly = updatedString.digits

        textField.text = applyPhoneMask(to: digitsOnly)

        return false
    }

    private func applyPhoneMask(to digits: String) -> String {
        var result = ""
        var index = digits.startIndex

        let mask = "+X (XXX) XXX XX XX"

        for ch in mask where index < digits.endIndex {
            if ch == "X" {
                result.append(digits[index])
                index = digits.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
}
