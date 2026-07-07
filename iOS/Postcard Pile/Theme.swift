import SwiftUI

/// Unique visual identity for Postcard Pile: faded travel-stamp terracotta with postmark teal.
enum Theme {
    static let accent = Color(hex: "#B5502A")
    static let accentSecondary = Color(hex: "#3E7C8C")
    static let background = Color(hex: "#FBF3E7")
    static let ink = Color(hex: "#2B1C12")

    static var titleFont: Font {
        Font.system(.largeTitle, design: .serif).weight(.bold)
    }

    static var bodyFont: Font {
        Font.system(.body, design: .serif)
    }

    static var cardCornerRadius: CGFloat { 18 }
}

extension Color {
    init(hex: String) {
        let s = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var v: UInt64 = 0
        Scanner(string: s).scanHexInt64(&v)
        let r = Double((v >> 16) & 0xFF) / 255.0
        let g = Double((v >> 8) & 0xFF) / 255.0
        let b = Double(v & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}
