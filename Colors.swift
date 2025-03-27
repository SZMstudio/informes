import SwiftUI

struct Colors {
    static let backgroundColor = Color(hex: "FFFFFF") // Blanco
    static let buttonColor = Color(hex: "0000FF") // Azul
    static let buttonTextColor = Color(hex: "FFFFFF") // Blanco
    static let secondaryColor = Color(hex: "808080") // Gris
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let red = Double((rgbValue & 0xff0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00ff00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000ff) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}
