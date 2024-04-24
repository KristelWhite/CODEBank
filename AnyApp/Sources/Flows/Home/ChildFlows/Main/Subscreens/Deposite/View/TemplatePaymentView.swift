//
//  TemplatePaymentView.swift
//  AnyApp
//
//  Created by Кристина Пастухова on 24.04.2024.
//

import UIKit
import UI
import AppIndependent

final class TemplatePaymentView: BackgroundPrimary {

    // MARK: - Private Properties

    private let titleLabel = Label(foregroundStyle: .textPrimary, fontStyle: .body2)
    private let image = ImageView(foregroundStyle: .contentAccentPrimary)
    
    private var props: Props?

    // MARK: - Public methods

    override public func setup() {
        super.setup()
    }

    // MARK: - Private methods
    
    
    private func body(with props: Props) -> UIView {
        HStack(spacing: 16) {
            BackgroundView {
                image
            }
            .backgroundStyle(.contentSecondary)
            .cornerRadius(20)
            .size(CGSize(width: 40, height: 40), priority: .required)
            VStack {
                FlexibleGroupedSpacer()
                titleLabel
                FlexibleGroupedSpacer()
            }
            .linkGroupedSpacers()
        }
        .layoutMargins(.make(vInsets: 14, hInsets: 16))
        .onTap { [weak self] in
            self?.props?.onTap?(props.id)
        }
    }
}

// MARK: - Configurable

extension TemplatePaymentView: ConfigurableView {
    
    typealias Model = Props
    
    struct Props: Hashable {
        let id: String
        let title: String
        let image: UIImage
        
        var onTap: StringHandler?
        
        public static func == (lhs: TemplatePaymentView.Props, rhs: TemplatePaymentView.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(title)
            hasher.combine(image)
        }
    }

    public func configure(with model: Props) {
        self.props = model
        subviews.forEach { $0.removeFromSuperview() }
        body(with: model).embed(in: self)
    }
}

