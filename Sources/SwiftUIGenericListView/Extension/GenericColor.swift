//
//  GenericColor.swift
//
//
//  Created by Raghava Dokala on 08/08/24.
//

import SwiftUI

import SwiftUI

extension Color {
    /// Initializes a color from a hexadecimal string and an alpha percentage (1-100).
    /// - Parameters:
    ///   - hex: The hexadecimal color code as a string. It can start with or without a `#`.
    ///   - alphaPercentage: The alpha value as a percentage from 1 to 100.
   public init(hex: String, alphaPercentage: Int? = 100) {
        let alpha = Double(alphaPercentage ?? 0) / 100.0
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0) // Default color for invalid hex input
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: alpha * Double(a) / 255
        )
    }
}
