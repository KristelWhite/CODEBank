import UIKit
import UI
import AppIndependent

final class TemplateHeaderView: BackgroundPrimary {

    // MARK: - Private Properties

    private let titleLabel = Label(foregroundStyle: .textTertiary, fontStyle: .body15)

    private var props: Props?

    // MARK: - Public methods

    override public func setup() {
        super.setup()
        body().embed(in: self)
    }

    // MARK: - Private methods

    private func body() -> UIView {
        VStack {
//            Shimmer().height(52).embed(in: titleLabel)
            titleLabel

        }
        .layoutMargins(.init(top: 17, left: 0, bottom: 15, right: 0))
    }
}

// MARK: - Configurable

extension TemplateHeaderView: ConfigurableView {

    typealias Model = Props

    struct Props: Hashable {
        var title: String

        public static func == (lhs: TemplateHeaderView.Props, rhs: TemplateHeaderView.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(title)
        }
    }

    public func configure(with model: Props) {
        titleLabel.text(model.title)
    }
}
