import Foundation
import UIKit

extension String {
  func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
    guard characters.count > 0 else { return 0 }

    let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
    let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin], attributes: [NSAttributedStringKey.font: font], context: nil)

    return ceil(boundingBox.height)
  }
}

extension NSAttributedString {
  func heightWithConstrainedWidth(width: CGFloat) -> CGFloat {
    let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
    let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)

    return ceil(boundingBox.height)
  }

  func widthWithConstrainedHeight(height: CGFloat) -> CGFloat {
    let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
    let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)

    return ceil(boundingBox.width)
  }
}
