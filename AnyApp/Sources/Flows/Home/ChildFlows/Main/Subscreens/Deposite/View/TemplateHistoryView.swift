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
        .multiline()
    private let dateLabel = Label(foregroundStyle: .textTertiary, fontStyle: .caption1)
    private let valueLabel = Label(foregroundStyle: .indicatorcontentDone, fontStyle: .body2)
    private let image = ImageView(foregroundStyle: .contentAccentPrimary)
    
    private var props: Props?

    // MARK: - Public methods

    override public func setup() {
        super.setup()
    }

    // MARK: - Private methods
    
    
    private func body(with props: Props) -> UIView {
        HStack(spacing: 16) {
            BackgroundView{
                image
                    .image(props.image)
            }
            .backgroundStyle(.contentSecondary)
            .size(CGSize(width: 40, height: 40), priority: .required)
            .cornerRadius(20)
            VStack(distribution: .fillEqually, spacing: 2) {
                HStack(distribution: .equalSpacing) {
                    dateLabel
                        .text(props.date)
                    valueLabel
                        .foregroundStyle(props.isIncome ? .indicatorcontentDone : .indicatorContentError)
                        .text(props.value)
                }
                titleLabel
                    .text(props.title)
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
        let date: String
        let value: String
        let image: UIImage
        let isIncome: Bool

        var onTap: StringHandler?

        public static func == (lhs: TemplateHistoryView.Props, rhs: TemplateHistoryView.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(title)
            hasher.combine(value)
            hasher.combine(image)
            hasher.combine(date)
            hasher.combine(isIncome)
        }
    }

    public func configure(with model: Props) {
        self.props = model
        subviews.forEach { $0.removeFromSuperview() }
        body(with: model).embed(in: self)
    }
}

