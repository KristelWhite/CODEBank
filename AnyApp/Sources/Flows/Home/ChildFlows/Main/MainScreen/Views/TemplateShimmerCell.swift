import UIKit
import UI
import AppIndependent

final class TemplateShimmerView: BackgroundPrimary {

    // MARK: - Public methods

    override public func setup() {
        super.setup()
        body().embed(in: self)
    }

    // MARK: - Private methods

    private func body() -> UIView {
        BackgroundView {
            VStack {
                Shimmer()
            }
            .layoutMargins(.make(vInsets: 8, hInsets: 16))
        }
        .height(52)
    }
}
