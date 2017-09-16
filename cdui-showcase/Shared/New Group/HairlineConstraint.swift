import UIKit

class HairlineConstraint: NSLayoutConstraint {
  override func awakeFromNib() {
    super.awakeFromNib()

    self.constant = 1.0 / UIScreen.main.scale
  }
}
