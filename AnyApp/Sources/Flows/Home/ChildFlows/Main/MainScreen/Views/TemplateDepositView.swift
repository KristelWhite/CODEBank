import UIKit
import UI
import AppIndependent

final class TemplateDepositView: BackgroundPrimary {

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
                        .text(String(props.value))
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

extension TemplateDepositView: ConfigurableView {

    typealias Model = Props

    struct Props: Hashable {
        let id: Int
        let title: String
        let rate: String
        let date: String
        let value: Double
        let currency: Currency

        var onTap: IntHandler?

        public static func == (lhs: TemplateDepositView.Props, rhs: TemplateDepositView.Props) -> Bool {
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
