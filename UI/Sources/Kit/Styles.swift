import UIKit

// Defines background color
public enum BackgroundStyle {
    case none
    case backgroundPrimary
    case backgroundSecondary
    case contentPrimary
    case contentSecondary
    case contentTertiary
    
    case indicatorContentError
    case indicatorContentSuccess
    case indicatorcontentDone
    
    case primaryButton
    case backgroundBottomMenu
    case overlay
    case calendarPeriod
    case secondaryButton
}

// Defines textColor and tintColor
public enum ForegroundStyle {
    case none
    case textSecondary
    case textTertiary
    case textPrimary
    
    case contentAccentPrimary
    case contentAccentSecondary
    case contentAccentTertiary

    case contentPrimary
    case button
    
    case contentSecondary
    
    case indicatorContentError
    case indicatorContentSuccess
    case indicatorcontentDone
}

// Defines borderColor
public enum BorderStyle {
    case none
    case template
    
}

// Defines font
public enum FontStyle {
    case title
    case lageTitle
    case subtitle
    case body20
    case body17
    case body1
    case body2
    case body15
    case button
    case caption1
    case caption2
    case timer
    case codeDigit
    case cardNumber
}

// Defines shadow properties
public enum ShadowStyle {
    case dropShadow1
}

// Defines gradient properties
public enum GradientStyle {
    case none
    case gradient1
}

public extension BackgroundStyle {

    var color: UIColor {
        switch self {
        case .none:
            return UIColor.clear
        case .backgroundPrimary:
            return Palette.Surface.backgroundPrimary
        case .backgroundSecondary:
            return Palette.Surface.backgroundSecondary
        case .contentPrimary:
            return Palette.Content.primary
        case .contentSecondary:
            return Palette.Content.secondary
        case .contentTertiary:
            return Palette.Content.tertiary
        case .indicatorContentError:
            return Palette.IndicatorContent.error
        case .indicatorContentSuccess:
            return Palette.IndicatorContent.success
        case .indicatorcontentDone:
            return Palette.IndicatorContent.done
        case .primaryButton:
            return Palette.Button.buttonPrimary
        case .backgroundBottomMenu:
            return Palette.Diffrent.backgroundBottomMenu
        case .overlay:
            return Palette.Diffrent.overlay
        case .calendarPeriod:
            return Palette.Diffrent.calendarPeriod
        case .secondaryButton:
            return Palette.Button.buttonSecondary
        }
    }
}

public extension ForegroundStyle {

    var color: UIColor {
        switch self {
        case .none:
            return UIColor.clear
        case .contentPrimary:
            return Palette.Content.primary
        case .textPrimary:
            return Palette.Text.primary
        case .button:
            return Palette.Button.buttonText
        case .textSecondary:
            return Palette.Text.secondary
        case .textTertiary:
            return Palette.Text.tertiary
        case .contentAccentPrimary:
            return Palette.Content.accentPrimary
        case .contentAccentSecondary:
            return Palette.Content.accentSecondary
        case .contentAccentTertiary:
            return Palette.Content.accentTertiary
        case .contentSecondary:
            return Palette.Content.secondary
        case .indicatorContentError:
            return Palette.IndicatorContent.error
        case .indicatorContentSuccess:
            return Palette.IndicatorContent.success
        case .indicatorcontentDone:
            return Palette.IndicatorContent.done
        }
    }
}

public extension BorderStyle {

    var color: UIColor {
        switch self {
        case .none:
            return UIColor.clear
        case .template:
            return UIColor.red
        }
    }
}

public extension FontStyle {

    var textStyle: TextStyle? {
        switch self {
        case .title:
            return Typography.title
        case .button:
            return Typography.button
        case .caption2:
            return Typography.caption2
        case .timer:
            return Typography.timer
        case .codeDigit:
            return Typography.codeDigit
        case .lageTitle:
            return Typography.largeTitle
        case .subtitle:
            return Typography.subtitle
        case .body20:
            return Typography.body20
        case .body17:
            return Typography.body17
        case .body1:
            return Typography.body1
        case .body2:
            return Typography.body2
        case .body15:
            return Typography.body15
        case .caption1:
            return Typography.caption1
        case .cardNumber:
            return Typography.cardNumber
        }
    }
}

public extension ShadowStyle {

    var shadowProps: ShadowProps {
        switch self {
        case .dropShadow1:
            return ShadowProps(radius: 16, color: Palette.Shadow.dropShadow1, offsetX: 0, offsetY: 8)
        }
    }
}

public extension GradientStyle {

    var gradientProps: GradientProps? {
        switch self {
        case .none:
            return nil
        case .gradient1:
            return Palette.Gradient.gradient1
        }
    }
}
