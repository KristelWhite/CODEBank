import UIKit

public final class SnackView: View {

    // MARK: - Types

    enum Constant {
        static let autohide: Bool = true
        static let appearDuration: TimeInterval = 0.2
        static let showDuration: TimeInterval = 3
    }

    enum Event {
        static let rootWillDisappear: String = "Snack.rootWillDisappear"
    }

    public struct Props: Equatable {

        public enum SnackStyle: Equatable {
            case basic
            case error
        }

        public let message: String
        public let style: SnackStyle

        public init(message: String, style: SnackStyle = .basic) {
            self.message = message
            self.style = style
        }

        public static func == (lhs: Props, rhs: Props) -> Bool {
            return lhs.message == rhs.message
        }
    }

    // MARK: - Public Properties

    var onDismiss: (() -> Void)?
    var props: Props

    // MARK: - Init

    required init(props: Props) {
        self.props = props
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Properties

    private var autohide: Bool = Constant.autohide
    private var showDuration: TimeInterval = Constant.showDuration


    private let titleLabel = Label()
        .fontStyle(.caption1)
        .foregroundStyle(.button)
        .multiline()

    private lazy var contentView = body()

    // MARK: - Lifecycle

    override public func willMove(toSuperview newSuperview: UIView?) {
        defer { super.willMove(toSuperview: newSuperview) }
        guard newSuperview != nil else { return }

        alpha = 0
        fadeIn()

        if autohide {
            startTimer()
        }
    }

    // MARK: - Public Methods

    override public func setup() {
        super.setup()

        let bodyView = body()
        addSubview(bodyView)
        bodyView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.center.equalToSuperview()
        }

        titleLabel.text(props.message)
        backgroundStyle(
            props.style == .basic
            ? .indicatorContentSuccess
            : .indicatorContentError
        )

        cornerRadius(12)
        shadowStyle(ShadowStyle.dropShadow1)
        clipsToBounds(false)

        setupSwipeToCloseGesture()
        setupCloseEvent()
    }

    public func setAutohide(_ autohide: Bool) {
        self.autohide = autohide
    }

    public func setShowTime(_ showDuration: TimeInterval) {
        self.showDuration = showDuration
    }

    // MARK: - Private Methods

    private func body() -> UIView {


            HStack(spacing: 16) {
                titleLabel
                FlexibleSpacer()
                ImageView(image: UIImage(named: "close"), foregroundStyle: .contentAccentTertiary)
                    .onTap { [weak self] in
                        self?.dismiss()
                    }
            }
        .layoutMargins(.all(17))
    }

    private func setupSwipeToCloseGesture() {
        let swipeGestureRecognizer = UISwipeGestureRecognizer(
            target: self,
            action: #selector(dismiss)
        )
        swipeGestureRecognizer.direction = .up
        addGestureRecognizer(swipeGestureRecognizer)
    }

    private func setupCloseEvent() {
        let closeEventName = NSNotification.Name(rawValue: Event.rootWillDisappear)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(dismiss),
            name: closeEventName,
            object: nil
        )
    }

    @objc private func startTimer() {
        Timer.scheduledTimer(
            timeInterval: showDuration,
            target: self,
            selector: #selector(dismiss),
            userInfo: nil,
            repeats: false
        )
    }

    @objc private func dismiss() {
        fadeOut { [weak self] in
            self?.onDismiss?()
            self?.removeFromSuperview()
        }
    }
}
