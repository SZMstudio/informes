import SwiftUI

struct Colors {
    static let primaryColor = Color(hex: "#1E90FF")
    static let secondaryColor = Color(hex: "#32CD32")
    static let backgroundColor = Color(hex: "#F5F5F5")
    static let buttonColor = Color(hex: "#1E90FF")
    static let buttonTextColor = Color(hex: "#FFFFFF")
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}
