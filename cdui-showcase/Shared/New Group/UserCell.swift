import Foundation
import UIKit

final class UserCell: UICollectionViewCell {
  static let nibName = "UserCell"
  static let reuseIdentifier = "UserCell"

  static let preferredHeight: CGFloat = 80

  var title: String? {
    didSet {
      titleLabel.text = title
    }
  }

  var subtitle: String? {
    didSet {
      subtitleLabel.text = subtitle
    }
  }

  var imageUrl: String? {
    didSet {
      imageView.load(imageUrl: imageUrl)
    }
  }

  @IBOutlet private weak var imageView: RemoteImageView!
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var subtitleLabel: UILabel!

  class func nib() -> UINib {
    return UINib(nibName: UserCell.nibName, bundle: Bundle(for: UserCell.self))
  }

  class func create() -> UserCell {
    return UserCell.nib().instantiate(withOwner: self, options: nil)[0] as! UserCell
  }

  override func awakeFromNib() {
    contentView.backgroundColor = Theme.Color.background

    titleLabel.text = ""
    subtitleLabel.text = ""

    imageView.backgroundColor = Theme.Color.background
    imageView.layer.borderWidth = 3
    imageView.layer.borderColor = Theme.Color.blue.cgColor

    titleLabel.textColor = Theme.Color.blue
    titleLabel.font = Theme.Font.smallBold

    subtitleLabel.textColor = Theme.Color.text
    subtitleLabel.font = Theme.Font.micro
  }

  override func prepareForReuse() {
    titleLabel.text = ""
    subtitleLabel.text = ""
    imageView.clear()
  }
}
