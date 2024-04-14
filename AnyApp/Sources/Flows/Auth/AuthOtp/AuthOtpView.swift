import UI
import UIKit
import AppIndependent

final class AuthOtpView: BackgroundPrimary {

    var onOtpFilled: VoidHandler?
    
    var instructionLabel: Label = {
        var label = Label(text: "На ваш номер отправлено SMS с кодом подтверждения", foregroundStyle: .textPrimary, fontStyle: .button)
        label.numberOfLines = 0
        return label
    }()
    var timerLabel: Label = {
        var label = Label(text: "Повторить через 2:59", foregroundStyle: .textPrimary, fontStyle: .timer)
        return label
    }()
    var codeTextFields: [TextField] = []
    var stackView = HStack(axis: .horizontal, alignment: .center, distribution: .equalSpacing, spacing: 6)
    var separator: View = {
        var view = View(backgroundStyle: .backgroundPrimary)
        view.snp.makeConstraints { make in
            make.height.equalTo(2)
            make.width.equalTo(10)
        }
        view.layer.backgroundColor = CGColor(red: 112/255, green: 109/255, blue: 118/255, alpha: 1)
        return view
    }()
    
    override func setup() {
        super.setup()
//        setupConstraints()
        setupTextFields()
        stackView.insertArrangedSubview(separator, at: 3)
        body().embed(in: self)
        actionButton = ButtonPrimary(title: "Авторизоваться")
            .onTap { [weak self] in
                self?.onOtpFilled?()
            }
        moveActionButtonWithKeyboard = true
    }

    private func body() -> UIView {
        VStack {
            Spacer(.px16)
            instructionLabel
            Spacer(.px24)
            stackView
            Spacer(.custom(length: 28))
            timerLabel
            FlexibleSpacer()
        }.layoutMargins(.make(vInsets: 16, hInsets: 16))
    }
    
    func setupTextFields() {
        (0..<6).forEach{ _ in
            let textField = TextField()
            textField.delegate = self
            textField.layer.cornerRadius = 10
            textField.layer.backgroundColor = CGColor.init(red: 108/255, green: 108/255, blue: 64/255, alpha: 1)
            textField.keyboardType = .numberPad
            textField.textAlignment = .center
            textField.font = UIFont.systemFont(ofSize: 20)
            textField.textColor = .white
            textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
            textField.borderStyle = .roundedRect
            codeTextFields.append(textField)
            stackView.addArrangedSubview(textField)
            textField.snp.makeConstraints { make in
                make.height.equalTo(48)
                make.width.equalTo(40)
            }
        }
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        
    }
    
//    func setupConstraints() {
//        stackView.snp.makeConstraints { make in
//            make.width.equalTo(286)
//            make.height.equalTo(48)
//        }
//    }
}

extension AuthOtpView: UITextFieldDelegate {
    
}
