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

    var props: Props?
    
    enum State {
        case history, action, payment
    }

    enum Event {
        case changeStateOn(state: State)
    }
    
    var onEvent: ((Event) -> Void)?
    
    // MARK: - Public methods
    
    override public func setup() {
        super.setup()
        body().embed(in: self)

    }
    // MARK: - Private methods

    private func body() -> UIView {
        HStack(alignment: .center, distribution: .fill, spacing: 40) {
            FlexibleGroupedSpacer()
            Shimmer()
            .size(.init(width: 56, height: 56), priority: .required)
            Shimmer()
            .size(.init(width: 56, height: 56), priority: .required)
            Shimmer()
            .size(.init(width: 56, height: 56), priority: .required)
            FlexibleGroupedSpacer()
        }
        .linkGroupedSpacers()
        .layoutMargins(.make(vInsets: 16))
    }
    
    private func body(with props: Props) -> UIView {
        HStack(alignment: .center, distribution: .fill, spacing: 40) {
            FlexibleGroupedSpacer()
            BackgroundView {
                VStack {
                    FlexibleGroupedSpacer()
                    ImageView(image: Asset.history.image, foregroundStyle: props.state == .history ? .contentAccentPrimary : .contentAccentTertiary )
                    FlexibleGroupedSpacer()
                }.linkGroupedSpacers()
            }
            .backgroundStyle( props.state == .history ? .contentAccentTertiary : .contentSecondary)
            .size(.init(width: 56, height: 56), priority: .required)
            .cornerRadius(28)
            .onTap { [weak self] in
                self?.props?.onTap?(.history)
            }
            BackgroundView {
                VStack {
                    FlexibleGroupedSpacer()
                    ImageView(image: Asset.bankAccount.image, foregroundStyle: props.state == .action ? .contentAccentPrimary : .contentAccentTertiary)
                    FlexibleGroupedSpacer()
                }.linkGroupedSpacers()
            }
            .backgroundStyle(props.state == .action ? .contentAccentTertiary : .contentSecondary)
            .size(.init(width: 56, height: 56), priority: .required)
            .cornerRadius(28)
            .onTap { [weak self] in
                self?.props?.onTap?(.action)
            }
            BackgroundView {
                VStack {
                    FlexibleGroupedSpacer()
                    ImageView(image: Asset.mainProduct.image, foregroundStyle: props.state == .payment ? .contentAccentPrimary : .contentAccentTertiary)
                    FlexibleGroupedSpacer()
                }.linkGroupedSpacers()
            }
            .backgroundStyle(props.state == .payment ? .contentAccentTertiary : .contentSecondary)
            .size(.init(width: 56, height: 56), priority: .required)
            .cornerRadius(28)
            .onTap { [weak self] in
                self?.props?.onTap?(.payment)
            }
            FlexibleGroupedSpacer()
        }
        .linkGroupedSpacers()
        .layoutMargins(.make(vInsets: 16))
    }
}

extension SwitchView: ConfigurableView {
    typealias Model = Props

    struct Props: Hashable {
        let state: State

        var onTap: ((State) -> Void)?

        public static func == (lhs: SwitchView.Props, rhs: SwitchView.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(state)
        }
    }

    public func configure(with model: Props) {
        self.props = model
        subviews.forEach { $0.removeFromSuperview() }
        body(with: model).embed(in: self)
    }
}
