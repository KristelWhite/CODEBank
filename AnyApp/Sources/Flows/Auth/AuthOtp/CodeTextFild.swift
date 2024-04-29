//
//  CodeTextFild.swift
//  AnyApp
//
//  Created by Кристина Пастухова on 29.04.2024.
//

import UI
import UIKit
import AppIndependent

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
