import UIKit

extension UIColor {
    public enum ColorHexType {
        case standard(StandardColorHex)
        case custom(UInt32)
        
        var hex: UInt32 {
            switch self {
            case .standard(let standard): return standard.rawValue
            case .custom(let hex): return hex
            }
        }
        
    }
    
    public enum StandardColorHex: UInt32 {
        case themeColor = 0x333337
    }
    
    convenience init(hex: UInt32) {
        let mask = 0x000000FF
        let r = Int(hex >> 16) & mask
        let g = Int(hex >> 8) & mask
        let b = Int(hex) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
    
    public convenience init(color: ColorHexType) {
        self.init(hex: color.hex)
    }
}
