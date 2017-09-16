import UIKit

struct Theme {
  struct Margin {
    // https://airbnb.design/building-a-visual-language/
    static var tiny: CGFloat { return 8 }
    static var small: CGFloat { return 16 }
    static var base: CGFloat { return 24 }
    static var large: CGFloat { return 48 }
    static var xlarge: CGFloat { return 64 }
  }

  struct Font {
    static var largeBold: UIFont {
      return Theme.FontFace.bold(size: 20)
    }

    static var large: UIFont {
      return Theme.FontFace.regular(size: 20)
    }

    static var baseBold: UIFont {
      return Theme.FontFace.semibold(size: 17)
    }

    static var base: UIFont {
      return Theme.FontFace.regular(size: 17)
    }

    static var smallBold: UIFont {
      return Theme.FontFace.semibold(size: 14)
    }

    static var small: UIFont {
      return Theme.FontFace.regular(size: 14)
    }

    static var micro: UIFont {
      return Theme.FontFace.regular(size: 11)
    }
  }

  private struct FontFace {
    static func regular(size: CGFloat) -> UIFont {
      return UIFont(name: "Montserrat-Regular", size: size)!
    }

    static func semibold(size: CGFloat) -> UIFont {
      return UIFont(name: "Montserrat-SemiBold", size: size)!
    }

    static func bold(size: CGFloat) -> UIFont {
      return UIFont(name: "Montserrat-Bold", size: size)!
    }
  }

  struct Color {
    // Initial variables
    static var black: UIColor { return UIColor(hex: "#000000") }

    static var greyDarker: UIColor { return UIColor(hex: "#535353") }
    static var greyDark: UIColor { return UIColor(hex: "#9E9E9E") }
    static var grey: UIColor { return UIColor(hex: "#EAEAEA") }
    static var greyLight: UIColor { return UIColor(hex: "#F8F8F8") }

    static var white: UIColor { return UIColor(hex: "#FFFFFF") }

    static var blue: UIColor { return UIColor(hex: "#0505E0") }

    // Derived variables
    static var text: UIColor { return Theme.Color.greyDarker }
    static var textLight: UIColor { return Theme.Color.greyDark }
    static var textInvert: UIColor { return Theme.Color.white }

    static var background: UIColor { return Theme.Color.white }
    static var selectedBackground: UIColor { return Theme.Color.greyLight }
    static var imageBackground: UIColor { return Theme.Color.grey }
  }

  static func setAppearance() {
    UIButton.appearance().tintColor = Theme.Color.black
    UIImageView.appearance().tintColor = Theme.Color.black
  }

}
