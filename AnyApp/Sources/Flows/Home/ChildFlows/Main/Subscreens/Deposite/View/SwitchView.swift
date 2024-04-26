//
//  TemplateTabView.swift
//  AnyApp
//
//  Created by Кристина Пастухова on 24.04.2024.
//

import UIKit
import UI
import AppIndependent

final class SwitchView: BackgroundPrimary {
    
    // MARK: - Private Properties
    
    
    private var historyImage = ImageView(image: Asset.history.image, foregroundStyle: .contentAccentPrimary)

    private let actionImage = ImageView(image: Asset.bankAccount.image, foregroundStyle: .contentAccentTertiary)
    private let paymentImage = ImageView(image: Asset.mainProduct.image, foregroundStyle: .contentAccentTertiary)
    
    private var historyView  =  BackgroundView()
    private var actionView =  BackgroundView()
    private var paymentView =  BackgroundView()
    
    var selectedView: Views = .history
    
    enum Views {
        case history, action, payment
    }

    enum Event {
        case tapHistory
        case tapAction
        case tapPayment
    }
    
    var onEvent: ((Event) -> Void)?
    
    // MARK: - Public methods
    
    override public func setup() {
        super.setup()
        setupViews()
        body().embed(in: self)
    }
    // MARK: - Private methods
    
    
    func setupViews() {
        historyView = BackgroundView {
            VStack {
                FlexibleGroupedSpacer()
                historyImage
                FlexibleGroupedSpacer()
            }.linkGroupedSpacers()
        }
        actionView = BackgroundView {
            VStack {
                FlexibleGroupedSpacer()
                actionImage
                FlexibleGroupedSpacer()
            }.linkGroupedSpacers()
        }
        paymentView = BackgroundView {
            VStack {
                FlexibleGroupedSpacer()
                paymentImage
                FlexibleGroupedSpacer()
            }.linkGroupedSpacers()
        }
    }
    
    func changeStyle(view: BackgroundView, imageView: ImageView, viewType: Views){
        view.backgroundStyle(.contentAccentTertiary)
        imageView.foregroundStyle(.contentAccentPrimary)
        switch selectedView {
        case .history:
            historyView.backgroundStyle(.contentSecondary)
            historyImage.foregroundStyle(.contentAccentTertiary)
        case .action:
            actionView.backgroundStyle(.contentSecondary)
            actionImage.foregroundStyle(.contentAccentTertiary)
        case .payment:
            paymentView.backgroundStyle(.contentSecondary)
            paymentImage.foregroundStyle(.contentAccentTertiary)
        }
        selectedView = viewType
    }
    
    private func body() -> UIView {
        HStack( alignment: .center, distribution: .fill, spacing: 40) {
            FlexibleGroupedSpacer()
            historyView
            .backgroundStyle(.contentAccentTertiary)
            .size(.init(width: 56, height: 56), priority: .required)
            .cornerRadius(28)
            .onTap { [weak self] in
                guard self?.selectedView != .history, let self = self else { return }
                self.changeStyle(view: self.historyView, imageView: self.historyImage, viewType: .history)
                self.onEvent?(.tapHistory)
                
            }
            actionView
            .backgroundStyle(.contentSecondary)
            .size(.init(width: 56, height: 56), priority: .required)
            .cornerRadius(28)
            .onTap { [weak self] in
                guard self?.selectedView != .action, let self = self else { return }
                self.changeStyle(view: self.actionView, imageView: self.actionImage, viewType: .action)
                self.onEvent?(.tapAction)
            }
            paymentView
            .backgroundStyle(.contentSecondary)
            .size(.init(width: 56, height: 56), priority: .required)
            .cornerRadius(28)
            .onTap { [weak self] in
                guard self?.selectedView != .payment, let self = self else { return }
                self.changeStyle(view: self.paymentView, imageView: self.paymentImage, viewType: .payment)
                self.onEvent?(.tapPayment)
            }
            FlexibleGroupedSpacer()
        }
        .linkGroupedSpacers()
        .layoutMargins(.make(vInsets: 16))
    }
}

//final class BackgroundView: BackgroundView {
//    public var isOn = false
//
//    @discardableResult
//    func isOn(_ isOn: Bool) -> Self {
//        self.isOn = isOn
//        backgroundStyle(isOn ? .contentAccentTertiary : .contentSecondary
//        )
//
//        return self
//    }
//}


//extension TemplateSwitchView: ConfigurableView {
//
//    typealias Model = Props
//
//    struct Props: Hashable {
//        let id: String
//        let title: String
//        let value: String
//        let currency: Currency
//
//        var onTap: StringHandler?
//
//        public static func == (lhs: TemplateSwitchView.Props, rhs: TemplateSwitchView.Props) -> Bool {
//            lhs.hashValue == rhs.hashValue
//        }
//
//        public func hash(into hasher: inout Hasher) {
//            hasher.combine(id)
//            hasher.combine(title)
//            hasher.combine(value)
//            hasher.combine(currency.textValue)
//        }
//    }
//
//    public func configure(with model: Props) {
//        self.props = model
//        subviews.forEach { $0.removeFromSuperview() }
//        body(with: model).embed(in: self)
//    }
//}


