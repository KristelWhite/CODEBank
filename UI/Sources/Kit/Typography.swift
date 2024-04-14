import UIKit

public enum Typography {

    public static let title = TextStyle(
        name: "title",
        size: 34,
        weight: .bold,
        lineHeight: 41
    )

    public static let caption2 = TextStyle(
        name: "caption2",
        size: 11,
        weight: .regular,
        lineHeight: 13
    )

    public static let button = TextStyle(
        name: "button",
        size: 15,
        weight: .semibold,
        lineHeight: 18
    )
    
    public static let timer = TextStyle(
        name: "timer",
        size: 13,
        weight: .regular,
        lineHeight: 16
    )
    
    public static let codeDigit = TextStyle(
        name: "codeDigit",
        size: 20,
        weight: .semibold,
        lineHeight: 25
    )
}
