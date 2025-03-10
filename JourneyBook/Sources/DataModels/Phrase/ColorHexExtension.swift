//
//  ColorHexExtension.swift
//  JourneyBook
//
//  Created by Jack Delaney on 10/03/2025.
//

import SwiftUI

extension Color {
    init?(hex: String) {
        var hexSanitised = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitised = hexSanitised.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var opacity: CGFloat = 1.0

        let length = hexSanitised.count

        guard Scanner(string: hexSanitised).scanHexInt64(&rgb) else {
            return nil
        }

        if length == 6 {
            red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            blue = CGFloat(rgb & 0x0000FF) / 255.0

        } else if length == 8 {
            red = CGFloat((rgb & 0xFF00_0000) >> 24) / 255.0
            green = CGFloat((rgb & 0x00FF_0000) >> 16) / 255.0
            blue = CGFloat((rgb & 0x0000_FF00) >> 8) / 255.0
            opacity = CGFloat(rgb & 0x0000_00FF) / 255.0

        } else {
            return nil
        }

        self.init(red: red, green: green, blue: blue, opacity: opacity)
    }

    func toHex() -> String? {
        let uic = UIColor(self)
        guard let components = uic.cgColor.components, components.count >= 3
        else {
            return nil
        }
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)

        if components.count >= 4 {
            a = Float(components[3])
        }

        if a != Float(1.0) {
            return String(
                format: "%02lX%02lX%02lX%02lX", lroundf(r * 255),
                lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        } else {
            return String(
                format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255),
                lroundf(b * 255))
        }
    }

}
