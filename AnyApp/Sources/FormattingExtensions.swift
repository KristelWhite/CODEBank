//
//  Formatting Extensions.swift
//  AnyApp
//
//  Created by Кристина Пастухова on 30.04.2024.
//

import Foundation

extension Double {
    func formattedAsCurrency(_ sign: String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = ""
        formatter.currencyGroupingSeparator = " "
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.decimalSeparator = ","
        let value = formatter.string(from: NSNumber(value: self)) ?? ""
        return value + " " + sign
    }
}

extension String {
    var lastFourCharacters: String {
        return String(self.suffix(4))
    }

    func maskCardNumber() -> String {
        guard self.count >= 16 else { return self }
        let maskedPrefix = Array(repeating: "****", count: 3).joined(separator: " ")
        return String(maskedPrefix + " " + self.lastFourCharacters)
    }

    func formatPhoneNumber() -> String {
        let countryCode = String(self.prefix(2))
        let operatorCode = String(self.dropFirst(2).prefix(3))
        let remainingDigits = String(self.dropFirst(5))
        let formattedPhoneNumber = "\(countryCode) (\(operatorCode)) *** - ** - \(remainingDigits.suffix(2))"

        return formattedPhoneNumber
    }
}

extension Int {
    func minutesAndSeconds() -> String {
        let minutes = self / 60
        let seconds = self % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
