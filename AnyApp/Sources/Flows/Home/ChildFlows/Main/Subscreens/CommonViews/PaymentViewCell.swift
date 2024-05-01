//
//  TemplatePaymentView.swift
//  AnyApp
//
//  Created by Кристина Пастухова on 24.04.2024.
//

import UIKit
import UI
import AppIndependent

final class PaymentViewCell: BackgroundPrimary {

    // MARK: - Private Properties

    private let titleLabel = Label(foregroundStyle: .textPrimary, fontStyle: .body2)
    private let image = ImageView(foregroundStyle: .contentAccentPrimary)

    private var props: Props?

    // MARK: - Public methods

    override public func setup() {
        super.setup()
        body().embed(in: self)
    }

    // MARK: - Private methods

    private func body() -> UIView {
        HStack(alignment: .center, spacing: 16) {
            Shimmer()
            .size(CGSize(width: 40, height: 40), priority: .required)
            VStack {
                FlexibleGroupedSpacer()
                Shimmer()
                    .size(CGSize(width: 100, height: 20))
                FlexibleGroupedSpacer()
            }
            .linkGroupedSpacers()
        }
        .layoutMargins(.make(vInsets: 14))
    }

    private func body(with props: Props) -> UIView {
        HStack(alignment: .center, spacing: 16) {
            BackgroundView(padding: 8) {
                image
                    .image(props.image)
            }
            .backgroundStyle(.contentSecondary)
            .cornerRadius(20)
            .size(CGSize(width: 40, height: 40), priority: .required)
            VStack {
                FlexibleGroupedSpacer()
                titleLabel
                    .text(props.title)
                FlexibleGroupedSpacer()
            }
            .linkGroupedSpacers()
        }
        .layoutMargins(.make(vInsets: 14))
        .onTap { [weak self] in
            self?.props?.onTap?(props.id)
        }
    }
}

// MARK: - Configurable

extension PaymentViewCell: ConfigurableView {

    typealias Model = Props

    struct Props: Hashable {
        let id: String
        let title: String
        let image: UIImage

        var onTap: StringHandler?

        public static func == (lhs: PaymentViewCell.Props, rhs: PaymentViewCell.Props) -> Bool {
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
