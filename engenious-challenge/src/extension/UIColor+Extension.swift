import UIKit

extension UIColor {
    
    convenience init(_ hex: UInt64, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: opacity)
    }
    
    convenience init(hex: String, opacity: Double = 1.0) {
        // convert the String into an UInt64 and then convert into Color
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#")
        {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(rgbValue, opacity: opacity)
    }
}
