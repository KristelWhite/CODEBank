import UI
import UIKit
import AppIndependent
import SnapKit

final class AuthPhoneView: BackgroundPrimary {
    
    var onAuth: StringHandler?

    private var phoneTextField = TextField(foregroundStyle: .textPrimary, fontStyle: .body2, placeholderForegroundStyle: .textTertiary, placeholderFontStyle: .body2)
    
    override func setup() {
        super.setup()
        configureTextField()
        body().embed(in: self)
        moveActionButtonWithKeyboard = true
        actionButton = ButtonPrimary(title: Entrance.enter)
            .height(52)
            .onTap { [weak self] in
                guard let self = self, let phone = self.phoneTextField.text else { return }
                if phone.count == 18 {
                    self.onAuth?(phone)
                } else {
                    SnackCenter.shared.showSnack(withProps: .init(message: "Пожалуйста, убедитесь, что вы правильно ввели номер телефона", style: .error))
                    //change text and image color
                }

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
                    ImageView(image: Asset.phone.image)
                        .foregroundStyle(.contentAccentPrimary)
                        .size(CGSize(width: 24, height: 24))
                    Spacer(.px16)
                    phoneTextField
                        .placeholder("Телефон")
                        .keyboardType(.numberPad)
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

    func configureTextField() {
        phoneTextField.delegate = self
    }
}
// MARK: - UITextFieldDelegate

extension AuthPhoneView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let fullString = (textField.text ?? "") as NSString
        let updatedString = fullString.replacingCharacters(in: range, with: string)
        print(updatedString)

        let digitsOnly = updatedString.digits
        print(digitsOnly)

        textField.text = applyPhoneMask(to: digitsOnly)

        return false
    }

    func applyPhoneMask(to digits: String) -> String {
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

//MARK: - extension String
extension String {
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
}

