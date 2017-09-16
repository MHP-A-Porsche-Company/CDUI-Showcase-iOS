import Foundation
import UIKit

extension UIColor {
  convenience init(hex: String) {
    var cString: String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased().filter { $0 != "#" }

    if (cString.characters.count) != 6 {
      self.init(white: 1, alpha: 0)
      return
    }

    var rgbValue: UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)

    self.init(
      red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
      alpha: CGFloat(1.0)
    )
  }

  func lighter(amount: CGFloat = 0.25) -> UIColor {
    return hueColorWithBrightnessAmount(1 + amount)
  }

  func darker(amount: CGFloat = 0.25) -> UIColor {
    return hueColorWithBrightnessAmount(1 - amount)
  }

  private func hueColorWithBrightnessAmount(_ amount: CGFloat) -> UIColor {
    var hue: CGFloat = 0
    var saturation: CGFloat = 0
    var brightness: CGFloat = 0
    var alpha: CGFloat = 0

    if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
      return UIColor( hue: hue,
                      saturation: saturation,
                      brightness: brightness * amount,
                      alpha: alpha )
    } else {
      return self
    }
  }
}
