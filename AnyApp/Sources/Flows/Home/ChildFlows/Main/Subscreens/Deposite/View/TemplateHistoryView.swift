//
//  TemplateHistoryView.swift
//  AnyApp
//
//  Created by Кристина Пастухова on 24.04.2024.
//

import UIKit
import UI
import AppIndependent

final class TemplateHistoryView: BackgroundPrimary {

    // MARK: - Private Properties

    private let titleLabel = Label(foregroundStyle: .textPrimary, fontStyle: .body2)
    private let rateLabel = Label(foregroundStyle: .textTertiary, fontStyle: .caption2)
    private let dateLabel = Label(foregroundStyle: .textTertiary, fontStyle: .caption2)
    private let valueLabel = Label(foregroundStyle: .contentAccentPrimary, fontStyle: .body2)
    private let image = ImageView(foregroundStyle: .contentAccentTertiary)
    
    private var props: Props?

    // MARK: - Public methods

    override public func setup() {
        super.setup()
    }

    // MARK: - Private methods
    
    
    private func body(with props: Props) -> UIView {
        HStack(spacing: 16) {
            VStack {
                FlexibleGroupedSpacer()
                BackgroundView {
                    image
                        .image(props.currency.imageValue)
                        .foregroundStyle(.contentAccentTertiary)
                }
                .backgroundStyle(.contentSecondary)
                .size(.init(width: 40, height: 40), priority: .required)
                .cornerRadius(20)
                FlexibleGroupedSpacer()
            }
            .height(44)
            .linkGroupedSpacers()
            VStack(distribution: .fillEqually, spacing: 4) {
                HStack(distribution: .equalSpacing) {
                    titleLabel
                        .text(props.title)
                    rateLabel
                        .text(props.rate)
                }
                HStack(distribution: .equalSpacing) {
                    valueLabel
                        .text(props.value)
                    dateLabel
                        .text(props.date)
                }
            }
        }
        .layoutMargins(.make(vInsets: 14, hInsets: 0))
        .onTap { [weak self] in
            self?.props?.onTap?(props.id)
        }
    }
    
   
}

// MARK: - Configurable

extension TemplateHistoryView: ConfigurableView {

    typealias Model = Props

    struct Props: Hashable {
        let id: String
        let title: String
        let rate: String
        let date: String
        let value: String
        let currency: Currency

        var onTap: StringHandler?

        public static func == (lhs: TemplateHistoryView.Props, rhs: TemplateHistoryView.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(title)
            hasher.combine(value)
            hasher.combine(rate)
            hasher.combine(date)
            hasher.combine(currency.textValue)
        }
    }

    public func configure(with model: Props) {
        self.props = model
        subviews.forEach { $0.removeFromSuperview() }
        body(with: model).embed(in: self)
    }
}

