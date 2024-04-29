import UI
import UIKit
import AppIndependent

final class AuthOtpView: BackgroundPrimary {
    enum Event {
        case refreshOtp
    }
    var onOutput: ((Event) -> Void)?

    var onOtpFilled: StringHandler?
    
    var timerLabel = Label(foregroundStyle: .textSecondary, fontStyle: .caption1)
    lazy var timerButton = HStack(spacing: 16) {
        ImageView(image: Asset.repay.image, foregroundStyle: .contentAccentPrimary)
        Label(text: "Выслать код повторно", foregroundStyle: .textPrimary, fontStyle: .caption1)
        FlexibleSpacer()
    }
    // MARK: - Timer

    var countdownTimer: Timer?

    let totalTime = 5
    var timeLeft = 5

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

        if timeLeft <= 0 {
            countdownTimer?.invalidate()
            countdownTimer = nil
            timerLabel.isHidden(true)
            timerButton.isHidden(false)
        }
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

extension Int {
    func minutesAndSeconds() -> String {
        let minutes = self / 60
        let seconds = self % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
