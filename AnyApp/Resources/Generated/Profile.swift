// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum Profile {
  /// О приложении
  public static let aboutApp = Profile.tr("Profile", "aboutApp", fallback: "О приложении")
  /// Звонок в службу поддержки
  public static let call = Profile.tr("Profile", "call", fallback: "Звонок в службу поддержки")
  /// Вы точно хотите выйти?
  public static let exit = Profile.tr("Profile", "exit", fallback: "Вы точно хотите выйти?")
  /// Выход
  public static let exitButton = Profile.tr("Profile", "exitButton", fallback: "Выход")
  /// Вы разлогинились
  public static let logout = Profile.tr("Profile", "logout", fallback: "Вы разлогинились")
  /// 8 (800) 000-00-00
  public static let phone = Profile.tr("Profile", "phone", fallback: "8 (800) 000-00-00")
  /// Профиль
  public static let profile = Profile.tr("Profile", "profile", fallback: "Профиль")
  /// Служба поддержки
  public static let support = Profile.tr("Profile", "support", fallback: "Служба поддержки")
  /// Тема приложения
  public static let theme = Profile.tr("Profile", "theme", fallback: "Тема приложения")
  /// Версия 0.0.1 beta
  public static let version = Profile.tr("Profile", "version", fallback: "Версия 0.0.1 beta")
  public enum Theme {
    /// Как в системе
    public static let auto = Profile.tr("Profile", "theme.auto", fallback: "Как в системе")
    /// Темная
    public static let dark = Profile.tr("Profile", "theme.dark", fallback: "Темная")
    /// Светлая
    public static let light = Profile.tr("Profile", "theme.light", fallback: "Светлая")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Profile {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
