// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum Asset {
  public static let accentColor = ColorAsset(name: "AccentColor")
  public static let bankAccount = ImageAsset(name: "Bank account")
  public static let payPass = ImageAsset(name: "PayPass")
  public static let accountIn = ImageAsset(name: "accountIn")
  public static let accountOut = ImageAsset(name: "accountOut")
  public static let addPlus = ImageAsset(name: "add plus")
  public static let arrowSwipe = ImageAsset(name: "arrow_swipe")
  public static let back = ImageAsset(name: "back")
  public static let bank = ImageAsset(name: "bank")
  public static let bankomat = ImageAsset(name: "bankomat")
  public static let camera1 = ImageAsset(name: "camera-1")
  public static let camera = ImageAsset(name: "camera")
  public static let card = ImageAsset(name: "card")
  public static let cardOut = ImageAsset(name: "cardOut")
  public static let cardWhite = ImageAsset(name: "card_white")
  public static let `case` = ImageAsset(name: "case")
  public static let checkOff = ImageAsset(name: "check_off")
  public static let checkOn = ImageAsset(name: "check_on")
  public static let radioOff = ImageAsset(name: "radio_off")
  public static let radioOk = ImageAsset(name: "radio_ok")
  public static let check = ImageAsset(name: "check")
  public static let chevronDown = ImageAsset(name: "chevron-down")
  public static let chevronRight = ImageAsset(name: "chevron-right")
  public static let chevronUp = ImageAsset(name: "chevron-up")
  public static let close = ImageAsset(name: "close")
  public static let contacts = ImageAsset(name: "contacts")
  public static let delete = ImageAsset(name: "delete")
  public static let doll24 = ImageAsset(name: "doll 24")
  public static let edit = ImageAsset(name: "edit")
  public static let eur24 = ImageAsset(name: "eur 24")
  public static let exchangeRates = ImageAsset(name: "exchange_rates")
  public static let eye = ImageAsset(name: "eye")
  public static let eyeOff = ImageAsset(name: "eye_off")
  public static let fee = ImageAsset(name: "fee")
  public static let headphone = ImageAsset(name: "headphone")
  public static let history = ImageAsset(name: "history")
  public static let info = ImageAsset(name: "info")
  public static let input = ImageAsset(name: "input")
  public static let loader = ImageAsset(name: "loader")
  public static let lock1 = ImageAsset(name: "lock-1")
  public static let lock = ImageAsset(name: "lock")
  public static let mail = ImageAsset(name: "mail")
  public static let mainProduct = ImageAsset(name: "main product")
  public static let message = ImageAsset(name: "message")
  public static let moonStars = ImageAsset(name: "moon-stars")
  public static let next = ImageAsset(name: "next")
  public static let nfc = ImageAsset(name: "nfc")
  public static let payment = ImageAsset(name: "payment")
  public static let _1Gibdd = ImageAsset(name: "1_GIBDD")
  public static let _1Internet = ImageAsset(name: "1_Internet")
  public static let _1Jkh = ImageAsset(name: "1_JKH")
  public static let _1Mobile = ImageAsset(name: "1_mobile")
  public static let _1Other = ImageAsset(name: "1_other")
  public static let _1Taxes = ImageAsset(name: "1_taxes")
  public static let _2AccountToAccount = ImageAsset(name: "2_AccountToAccount")
  public static let _2AccountPay = ImageAsset(name: "2_accountPay")
  public static let _2CardPay = ImageAsset(name: "2_cardPay")
  public static let _2MobilePay = ImageAsset(name: "2_mobilePay")
  public static let pdf = ImageAsset(name: "pdf")
  public static let phone = ImageAsset(name: "phone")
  public static let phoneCall = ImageAsset(name: "phone_call")
  public static let phonePhone = ImageAsset(name: "phone_phone")
  public static let photo = ImageAsset(name: "photo")
  public static let question = ImageAsset(name: "question")
  public static let recoverPassword = ImageAsset(name: "recover_password")
  public static let rename = ImageAsset(name: "rename")
  public static let repay = ImageAsset(name: "repay")
  public static let requisites = ImageAsset(name: "requisites")
  public static let reverse = ImageAsset(name: "reverse")
  public static let route = ImageAsset(name: "route")
  public static let rubs24 = ImageAsset(name: "rubs 24")
  public static let search = ImageAsset(name: "search")
  public static let settings = ImageAsset(name: "settings")
  public static let share = ImageAsset(name: "share")
  public static let shopping = ImageAsset(name: "shopping")
  public static let star = ImageAsset(name: "star")
  public static let cancel = ImageAsset(name: "cancel")
  public static let hold = ImageAsset(name: "hold")
  public static let marker = ImageAsset(name: "marker")
  public static let refresh = ImageAsset(name: "refresh")
  public static let star1 = ImageAsset(name: "star1")
  public static let touch = ImageAsset(name: "touch")
  public static let trash = ImageAsset(name: "trash")
  public static let user = ImageAsset(name: "user")
  public static let icon = ImageAsset(name: "@icon")
  public static let headerShareIcon = ImageAsset(name: "Header Share Icon")
  public static let fingerprint = ImageAsset(name: "fingerprint")
  public static let account = ImageAsset(name: "account")
  public static let add = ImageAsset(name: "add")
  public static let bind = ImageAsset(name: "bind")
  public static let icEur = ImageAsset(name: "ic_eur")
  public static let icUsd = ImageAsset(name: "ic_usd")
  public static let acado = ImageAsset(name: "Acado")
  public static let golden = ImageAsset(name: "Golden")
  public static let mts = ImageAsset(name: "MTS")
  public static let pochtaBank = ImageAsset(name: "PochtaBank")
  public static let tinkoff = ImageAsset(name: "Tinkoff")
  public static let alternativa = ImageAsset(name: "alternativa")
  public static let beeline = ImageAsset(name: "beeline")
  public static let energo = ImageAsset(name: "energo")
  public static let gaz = ImageAsset(name: "gaz")
  public static let kode = ImageAsset(name: "kode")
  public static let megafon = ImageAsset(name: "megafon")
  public static let rostelecom = ImageAsset(name: "rostelecom")
  public static let tele2 = ImageAsset(name: "tele2")
  public static let vodokanal = ImageAsset(name: "vodokanal")
  public static let yantar = ImageAsset(name: "yantar")
  public static let yota = ImageAsset(name: "yota")
  public static let whiteMe = ImageAsset(name: "white_me")
  public static let whiteMinus = ImageAsset(name: "white_minus")
  public static let whitePlus = ImageAsset(name: "white_plus")
  public static let masterCard32 = ImageAsset(name: "MasterCard32")
  public static let off = ImageAsset(name: "off")
  public static let on = ImageAsset(name: "on")
  public static let mediumIcon = ImageAsset(name: "medium icon")
  public static let ruble = ImageAsset(name: "ruble")
  public static let ok = ImageAsset(name: "ok")
  public static let touchId = ImageAsset(name: "touch id")
  public static let bigIlustrtion11 = ImageAsset(name: "big ilustrtion 1-1")
  public static let bigIlustrtion1 = ImageAsset(name: "big ilustrtion 1")
  public static let bigIlustrtionFaceId = ImageAsset(name: "big ilustrtion face id")
  public static let bigIlustrtionNotServer = ImageAsset(name: "big ilustrtion not server")
  public static let bigIlustrtionNotWiFi = ImageAsset(name: "big ilustrtion not wi-fi")
  public static let bigIlustrtionPinCode = ImageAsset(name: "big ilustrtion pin code")
  public static let icon1 = ImageAsset(name: "@icon-1")
  public static let icon2 = ImageAsset(name: "@icon-2")
  public static let me = ImageAsset(name: "ME")
  public static let title = ImageAsset(name: "Title")
  public static let touch2 = ImageAsset(name: "touch2")
  public static let notificationBadge = ImageAsset(name: "Notification Badge")
  public static let masterCard = ImageAsset(name: "MasterCard")
  public static let visa = ImageAsset(name: "Visa")
  public static let whitePlusDots = ImageAsset(name: "white_plus dots")
  public static let icon3 = ImageAsset(name: "@icon-3")
  public static let messages = ImageAsset(name: "Messages")
  public static let logoLarge = ImageAsset(name: "logo large")
  public static let logo = ImageAsset(name: "logo")
  public static let logoSmall = ImageAsset(name: "logo_small")
  public static let bankCard = ImageAsset(name: "BankCard")
  public static let bankCardDisable = ImageAsset(name: "BankCardDisable")
  public static let raiffaizen = ImageAsset(name: "Raiffaizen")
  public static let sberbank = ImageAsset(name: "Sberbank")
  public static let vtb24 = ImageAsset(name: "VTB24")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class ColorAsset {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  public private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  public func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = BundleToken.bundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public private(set) lazy var swiftUIColor: SwiftUI.Color = {
    SwiftUI.Color(asset: self)
  }()
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Color {
  init(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }
}
#endif

public struct ImageAsset {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  public var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  public func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

public extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Image {
  init(asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }

  init(asset: ImageAsset, label: Text) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

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
