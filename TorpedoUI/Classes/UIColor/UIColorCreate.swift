import Foundation
import UIKit

enum ColorCreateError: Error {
    case hexStringNotSixChars
    case rgbaValuesUnretrievable
}

public extension UIColor {

    public convenience init(hexString: String) throws {
        var cString: NSString = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased() as NSString

        if (cString.hasPrefix("#")) {
            cString = cString.substring(from: 1) as NSString
        }

        guard cString.length == 6 else {
            throw ColorCreateError.hexStringNotSixChars
        }

        let rString = cString.substring(to: 2)
        let gSubString = cString.substring(from: 2) as NSString
        let gString = gSubString.substring(to: 2)
        let bSubString = cString.substring(from: 4) as NSString
        let bString = bSubString.substring(to: 2)

        var r: CUnsignedInt = 0, g: CUnsignedInt = 0, b: CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }

    public func darkerColor() throws -> UIColor {
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 0.0
        guard getRed(&r, green: &g, blue: &b, alpha: &a) else {
            throw ColorCreateError.rgbaValuesUnretrievable
        }
        return UIColor(red: max(r - 0.1, 0), green: max(g - 0.1, 0), blue: max(b - 0.1, 0), alpha: a)
    }

    public func lighterColor() throws -> UIColor {
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 0.0
        guard getRed(&r, green: &g, blue: &b, alpha: &a) else {
            throw ColorCreateError.rgbaValuesUnretrievable
        }
        return UIColor(red: min(r + 0.1, 0), green: min(g + 0.1, 0), blue: min(b + 0.1, 0), alpha: a)
    }

}
