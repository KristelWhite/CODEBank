// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum Main {
  /// Привязанные карты
  public static let activeCards = Main.tr("Main", "activeCards", fallback: "Привязанные карты")
  /// Карты
  public static let cards = Main.tr("Main", "cards", fallback: "Карты")
  /// Закрыть счет
  public static let closeDeposit = Main.tr("Main", "closeDeposit", fallback: "Закрыть счет")
  /// Реквизиты счета
  public static let depositInfo = Main.tr("Main", "depositInfo", fallback: "Реквизиты счета")
  /// Счета
  public static let deposits = Main.tr("Main", "deposits", fallback: "Счета")
  /// ЖКХ
  public static let houseHold = Main.tr("Main", "houseHold", fallback: "ЖКХ")
  /// Интернет
  public static let intermet = Main.tr("Main", "intermet", fallback: "Интернет")
  /// Main.strings
  ///   AnyApp
  /// 
  ///   Created by Кристина Пастухова on 01.05.2024.
  public static let main = Main.tr("Main", "main", fallback: "Главная")
  /// Мобильная связь
  public static let mobile = Main.tr("Main", "mobile", fallback: "Мобильная связь")
  /// Открыть новый счет или продукт
  public static let newProgect = Main.tr("Main", "newProgect", fallback: "Открыть новый счет или продукт")
  /// Переименовать счет
  public static let renameDeposit = Main.tr("Main", "renameDeposit", fallback: "Переименовать счет")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Main {
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
