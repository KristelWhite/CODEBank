import UI
import UIKit
import AppIndependent

final class AuthOtpView: BackgroundPrimary {
    enum Event {
        case refreshOtp
    }
    var onOutput: ((Event) -> Void)?
    enum Input {
        case errorCondition(Int)
    }

    var onOtpFilled: StringHandler?
    
    var timerLabel = Label(foregroundStyle: .textSecondary, fontStyle: .caption1)
    lazy var timerButton = HStack(spacing: 16) {
        ImageView(image: Asset.repay.image, foregroundStyle: .contentAccentPrimary)
        Label(text: "Выслать код повторно", foregroundStyle: .textPrimary, fontStyle: .caption1)
        FlexibleSpacer()
    }
    var errorLabel = Label( foregroundStyle: .indicatorContentError, fontStyle: .caption1)

    // MARK: - Timer

    var countdownTimer: Timer?
    var errorTimer: Timer?

    let totalTime = 7
    var timeLeft = 7

    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
        timeLeft = totalTime
        timerLabel.text(Entrance.timer("\(timeLeft.minutesAndSeconds())"))
        timerButton.isHidden(true)
        timerLabel.isHidden(false)
    }

    @objc func updateTimer() {
        timeLeft -= 1
        timerLabel.text(Entrance.timer("\(timeLeft.minutesAndSeconds())"))
        if errorTimer == nil {
            timerLabel.isHidden(false)
        }
            if timeLeft <= 0 {
                countdownTimer?.invalidate()
                countdownTimer = nil
                if errorTimer == nil {
                    timerLabel.isHidden(true)
                    timerButton.isHidden(false)
                }
            }
    }
    func handle(input: Input) {
        switch input {
        case .errorCondition(let count):

            for textFild in codeTextFields {
                textFild.foregroundStyle(.indicatorContentError)
                textFild.tintColor(.clear)
            }
            timerLabel.isHidden(true)
            timerButton.isHidden(true)
            errorLabel
                .text("Неверный код. У вас осталось \(count) попытки")
                .isHidden(false)
            errorTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(finishErrorCondition), userInfo: nil, repeats: false)
        }
    }

    @objc func finishErrorCondition() {
        print("end timer")
        errorTimer?.invalidate()
        errorTimer = nil
        for textFild in codeTextFields {
            textFild.foregroundStyle(.textPrimary)
            textFild.tintColor(.clear)
        }

        if countdownTimer == nil {
            timerButton.isHidden(false)
        } else {
            timerLabel.isHidden(false)
        }
        errorLabel
            .isHidden(true)

    }


    var codeTextFields: [CodeTextField] = []
    
    override func setup() {
        super.setup()
        setupTextFields()
        body().embed(in: self)
        actionButton = ButtonPrimary(title: "Авторизоваться")
            .onTap { [weak self] in
                //input otp from textfilds
                self?.onOtpFilled?("")
            }
        moveActionButtonWithKeyboard = true
        startTimer()
    }

    private func body() -> UIView {
        VStack(spacing: 24) {
            Label(text: "На ваш номер отправлено SMS с кодом подтверждения", foregroundStyle: .textPrimary, fontStyle: .body2)
                .multiline()
            HStack(alignment: .center, spacing: 6) {
                ForEach(collection: codeTextFields[0...2], spacing: 6, axis: .horizontal) {$0}
                View(backgroundStyle: .contentTertiary)
                    .size(CGSize(width: 10, height: 2), priority: .required)
                ForEach(collection: codeTextFields[3...5], spacing: 6, axis: .horizontal) {$0}
                FlexibleSpacer()
            }
            timerLabel
            timerButton
                .isHidden(true)
                .onTap { [weak self] in
                    self?.onOutput?(.refreshOtp)
                    self?.startTimer()

                }
            errorLabel
                .isHidden(true)
            FlexibleSpacer()
        }.layoutMargins(.make(vInsets: 16, hInsets: 16))
    }
    
    func setupTextFields() {
        (0..<6).forEach { _ in
            let textField = CodeTextField()
                .size(CGSize(width: 40, height: 48))
            textField.delegate = self
            textField.onDeleteBackward = { [weak self] in
                print("delete")
                self?.previousTextField(textField)
            }
            textField.clearsOnBeginEditing = true
            codeTextFields.append(textField)
        }
    }
}

extension AuthOtpView: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.count == 1 {
            textField.text = string
            nextTextField(textField)
            return false
        }
        return true
    }

    private func previousTextField(_ textField: UITextField) {
        if let index = codeTextFields.firstIndex(of: textField as! CodeTextField), index > 0 {
            let previousField = codeTextFields[index - 1]
            previousField.text = ""
            previousField.becomeFirstResponder()
        }
    }

    private func nextTextField(_ textField: UITextField) {
        if let index = codeTextFields.firstIndex(of: textField as! CodeTextField), index < codeTextFields.count - 1 {
            codeTextFields[index + 1].becomeFirstResponder()
        } else {
            textField.resignFirstResponder()

            self.onOtpFilled?(codeTextFields.compactMap({ field in
                field.text
            }).joined())
        }
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let firstEmptyField = codeTextFields.first(where: { $0.text?.isEmpty ?? true })
        if let emptyField = firstEmptyField {
            if textField == emptyField {
                return true
            } else {
                emptyField.becomeFirstResponder()
                return false
            }
        } else {
            if textField == codeTextFields.last {
                return true
            } else {
                codeTextFields.last?.becomeFirstResponder()
                return false
            }
        }
    }
//    func textFieldDidBeginEditing(_ textField: UITextField)
//        {
//            let firstEmptyField = codeTextFields.first(where: { $0.text?.isEmpty ?? true })
//            if let emptyField = firstEmptyField {
//                if textField == emptyField {
//                    textField.becomeFirstResponder()
//                } else {
//                    textField.resignFirstResponder()
//                    emptyField.becomeFirstResponder()
//
//                }
//            } else {
//                if textField == codeTextFields.last {
//                    textField.becomeFirstResponder()
//                } else {
//                    textField.resignFirstResponder()
//                    codeTextFields.last?.becomeFirstResponder()
//
//                }
//            }
//    }
}


