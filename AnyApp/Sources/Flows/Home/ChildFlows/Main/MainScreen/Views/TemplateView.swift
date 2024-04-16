import UIKit
import UI
import AppIndependent

final class TemplateView: BackgroundPrimary {

    // MARK: - Private Properties

    private let titleLabel = Label(foregroundStyle: .textPrimary, fontStyle: .body2)
//    private let descriptionLabel = Label(foregroundStyle: .textPrimary)
//        .multiline()
    private let rateLabel = Label(foregroundStyle: .textTertiary, fontStyle: .caption2)
    private let dateLabel = Label(foregroundStyle: .textTertiary, fontStyle: .caption2)
    private let valueLabel = Label(foregroundStyle: .contentAccentPrimary, fontStyle: .body2)
    private let image = ImageView().size(CGSize(width: 40, height: 40))
    
    private var props: Props?

    // MARK: - Public methods

    override public func setup() {
        super.setup()
//        cornerRadius(16)
//        borderStyle(.template, width: 1)
    }

    // MARK: - Private methods
    
    
    private func body(with props: Props) -> UIView {
        HStack(spacing: 16) {
            VStack {
                Spacer(.px2)
                image
//                    .layoutMargins(.make(vInsets: 2, hInsets: 0))
                Spacer(.px2)
            }
            VStack(distribution: .fillEqually, spacing: 4) {
                HStack(distribution: .equalSpacing) {
                    titleLabel
                        .text(props.title)
                    rateLabel
                        .text(props.description)
                }
                HStack(distribution: .equalSpacing) {
                    valueLabel
                        .text(props.description)
                    dateLabel
                        .text(props.description)
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

extension TemplateView: ConfigurableView {

    typealias Model = Props

    struct Props: Hashable {
        let id: String
        let title: String
        let description: String

        var onTap: StringHandler?

        public static func == (lhs: TemplateView.Props, rhs: TemplateView.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(title)
            hasher.combine(description)
        }
    }

    public func configure(with model: Props) {
        self.props = model
        subviews.forEach { $0.removeFromSuperview() }
        body(with: model).embed(in: self)
    }
}
