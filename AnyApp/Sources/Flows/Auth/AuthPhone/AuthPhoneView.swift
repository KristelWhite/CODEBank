import UI
import UIKit
import AppIndependent
import SnapKit

final class AuthPhoneView: BackgroundPrimary {
    
    var onAuth: VoidHandler?
    
    var headerView = ImageView(image: Asset.logo.image )
    var phoneTextField = PhoneTextField(placeholder: "Телефон")
    var viewHeightConstraint: Constraint!
    
    override func setup() {
        super.setup()
        body().embed(in: self)
        moveActionButtonWithKeyboard = true
        actionButton = ButtonPrimary(title: Entrance.enter)
            .onTap { [weak self] in
                self?.onAuth?()
            }
        headerView.snp.makeConstraints { (make) in
            viewHeightConstraint = make.height.equalTo(59).constraint
//            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
        }
        phoneTextField.snp.makeConstraints { (make) in
            make.height.equalTo(52)
//            make.top.equalTo(headerView.snp.bottom).offset(21)
        }
        actionButton?.snp.makeConstraints({ make in
            make.height.equalTo(52)
        })
        
        
        
    }
    
    private func body() -> UIView {
        VStack {
            Spacer(.px16)
            headerView
            Spacer(.px20)
            phoneTextField
            FlexibleGroupedSpacer()
        }
        .linkGroupedSpacers()
        .layoutMargins(.make(hInsets: 16))
    }
    
//    private func textField() -> TextField {
//        var textField = TextField(frame: CGRect(x: 0, y: 0, width: self.frame.width - 100, height: 52))
//
//        textField.placeholder = "Телефон"
//        let iconView = UIImageView(image: UIImage(named: "phone"))
//        //                iconView.frame = CGRect(x: 0, y: 0, width: iconView.image!.size.width + 20, height: iconView.image!.size.height)
//        //                iconView.contentMode = .center
//
//        textField.leftView = iconView
//        textField.leftViewMode = .always
//        textField.cornerRadius = 40
//        textField.backgroundColor = .gray
//        return textField
//
//    }
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
        keyboardType = .numberPad
        var iconView = UIImageView(image: Asset.phone.image)
        iconView.contentMode = .center
        leftView = iconView
        leftViewMode = .always
        layer.cornerRadius = 20
        layer.backgroundColor = CGColor(red: 112/255, green: 109/255, blue: 118/255, alpha: 1)
        textColor = .white
//        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 112/255, green: 109/255, blue: 118/255)])
        attributedPlaceholder = NSAttributedString(string: placeholder)
        font = .systemFont(ofSize: 15, weight: .regular)
        heightAnchor.constraint(equalToConstant: 52).isActive = true
    }
}

//private func textField() -> UIView {
//        HStack {
//            ImageView(image: Asset.phone.image)
//            Spacer(.px16)
//            TextField(placeholder: Entrance.phone)
//        }
//    }

//final class PhoneView: View {
//
//    var textField = TextField()
//    var imageView = ImageView()
//    var hStack = HStack()
//
//    init(frame: CGRect) {
//        super.init()
//
//        configure()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        configure()
//    }
//
//    func configure() {
//        textField.placeholder(Entrance.phone)
//        textField.textColor = .red
////        UIColor(red: 112/255, green: 109/255, blue: 118/255)
//        textField.font = .systemFont(ofSize: 15, weight: .regular)
//        textField.text = "jnjkn"
//
//        var image = Asset.phone.image
//        imageView.image = image
//
//        self.layer.cornerRadius = 30
//        self.backgroundColor = .gray
//
//
//        hStack.axis = .horizontal
//
//        hStack.addSubview(imageView)
//        hStack.addSubview(textField)
//        hStack.spacing = 16
//        hStack.translatesAutoresizingMaskIntoConstraints = false
//        translatesAutoresizingMaskIntoConstraints = false
//
//        self.addSubview(hStack)
//    }
//
//    func setupConstraints() {
//        NSLayoutConstraint.activate([hStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 14), hStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -14), hStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24), hStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)])
//    }
//
//}


//     TextField { textField in
//                let iconView = UIImageView(image: UIImage(named: "phone"))
//                iconView.frame = CGRect(x: 0, y: 0, width: iconView.image!.size.width + 20, height: iconView.image!.size.height)
//                iconView.contentMode = .center
//
//                textField.leftView = iconView
//                textField.leftViewMode = .always
//
//                textField.placeholder("номер")
//            }


//textField()
            
//            TextField(placeholder: Entrance.phone) { textField in
//                let iconView = UIImageView(image: UIImage(named: "phone"))
//                //                iconView.frame = CGRect(x: 0, y: 0, width: iconView.image!.size.width + 20, height: iconView.image!.size.height)
//                //                iconView.contentMode = .center
//
//                textField.leftView = iconView
//                textField.leftViewMode = .always
//                textField.frame = CGRect(x: 0, y: 0, width: 80, height: 100)
//                textField.cornerRadius = 40
//                textField.backgroundColor = .gray
//
//                //                textField.placeholder("номер")
//            }
            
            //            textField()
            //            .layoutMargins(.make(vInsets: 0, hInsets: 2))
            //            .backg
