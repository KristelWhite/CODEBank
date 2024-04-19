import UI
import UIKit
import AppIndependent

final class AuthOtpView: BackgroundPrimary {

    var onOtpFilled: VoidHandler?
    
    var timerLabel = Label(text: Entrance.timer("2:59"), foregroundStyle: .textSecondary, fontStyle: .caption1)
    var codeTextFields: [CodeTextField] = []
    
    override func setup() {
        super.setup()
        setupTextFields()
        body().embed(in: self)
        actionButton = ButtonPrimary(title: "Авторизоваться")
            .onTap { [weak self] in
                self?.onOtpFilled?()
            }
        moveActionButtonWithKeyboard = true
    }

    private func body() -> UIView {
        VStack {
//            Spacer(.px16)
            Label(text: "На ваш номер отправлено SMS с кодом подтверждения", foregroundStyle: .textPrimary, fontStyle: .body2)
                .multiline()
            Spacer(.px24)
            HStack(alignment: .center, spacing: 6) {
                ForEach(collection: codeTextFields[0...2], spacing: 6, axis: .horizontal) {$0}
                View(backgroundStyle: .contentTertiary)
                    .size(CGSize(width: 10, height: 2), priority: .required)
                ForEach(collection: codeTextFields[3...5], spacing: 6, axis: .horizontal) {$0}
                FlexibleSpacer()
            }
            Spacer(.custom(length: 28))
            timerLabel
            FlexibleSpacer()
        }.layoutMargins(.make(vInsets: 16, hInsets: 16))
    }
    
    func setupTextFields() {
        (0..<6).forEach { _ in
            let textField = CodeTextField()
                .size(CGSize(width: 40, height: 48))
                .onTap {
                    print("нажали на textfield")
                }
            textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
            textField.delegate = self
            codeTextFields.append(textField)
        }
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        
    }
}

extension AuthOtpView: UITextFieldDelegate {
    
}


final class CodeTextField: TextField {
    private var bottomLine = UIView()
   
    let activeLineColor = Palette.Content.accentPrimary
    let inactiveLineColor = UIColor.clear
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupAppearance()
        setupBottomLine()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
        setupBottomLine()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAppearance() {
        layer.cornerRadius = 14
        layer.masksToBounds = true
        backgroundColor = Palette.Content.secondary
        keyboardType = .numberPad
        textAlignment = .center
        font = Typography.subtitle?.font
        textColor = Palette.Text.primary
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
