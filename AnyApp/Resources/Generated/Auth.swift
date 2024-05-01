// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum Entrance {
  /// На ваш номер отправлено SMS с кодом подтверждения
  public static let checkSMS = Entrance.tr("Auth", "checkSMS", fallback: "На ваш номер отправлено SMS с кодом подтверждения")
  /// Войти
  public static let enter = Entrance.tr("Auth", "enter", fallback: "Войти")
  /// Авторизоваться
  public static let login = Entrance.tr("Auth", "login", fallback: "Авторизоваться")
  /// Телефон
  public static let phone = Entrance.tr("Auth", "phone", fallback: "Телефон")
  /// Выслать код повторно
  public static let repeatCode = Entrance.tr("Auth", "repeatCode", fallback: "Выслать код повторно")
  /// Повторить через %@
  public static func timer(_ p1: Any) -> String {
    return Entrance.tr("Auth", "timer", String(describing: p1), fallback: "Повторить через %@")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Entrance {
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
