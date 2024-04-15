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
        var label = Label(text: Entrance.timer("2:59"), foregroundStyle: .textPrimary, fontStyle: .timer)
        return label
    }()
    var codeTextFields: [CodeTextField] = []
    var stackView = HStack(axis: .horizontal, alignment: .center, distribution: .fill, spacing: 6)
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
        stackView.addArrangedSubview(FlexibleSpacer())
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
            let textField = CodeTextField()
            textField.delegate = self
            textField.layer.cornerRadius = 14
            textField.layer.masksToBounds = true
            textField.layer.backgroundColor = .init(red: 64, green: 58, blue: 71, alpha: 1)
//            textField.layer.backgroundColor = .init(red: 178, green: 178, blue: 178, alpha: 1)
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


final class CodeTextField: TextField {
    private var bottomLine = UIView()
   
    let activeLineColor = UIColor(red: 108, green: 120, blue: 230, alpha: 1)
    let inactiveLineColor = UIColor.clear
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupBottomLine()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBottomLine()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBottomLine() {
        bottomLine.backgroundColor = inactiveLineColor
        addSubview(bottomLine)
        bottomLine.snp.makeConstraints { make in
            make.width.equalTo(24)
            make.height.equalTo(2)
            make.bottom.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
        }
        tintColor = .clear
    }
// MARK: - Override
    override func becomeFirstResponder() -> Bool {
        let becomingActive = super.becomeFirstResponder()
        if becomingActive {
            bottomLine.backgroundColor = activeLineColor
        }
        return becomingActive
    }
    override func resignFirstResponder() -> Bool {
        let resigningActive = super.resignFirstResponder()
        if resigningActive {
            bottomLine.backgroundColor = inactiveLineColor
        }
        return resigningActive
    }
}
