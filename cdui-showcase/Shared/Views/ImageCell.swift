import Foundation
import UIKit

class ImageCell: UICollectionViewCell {
  static let reuseIdentifier: String = "ImageCell"

  var imageUrl: String? {
    didSet {
      imageView.imageUrl = imageUrl
      setNeedsLayout()
    }
  }

  var options = ImageCell.defaultOptions {
    didSet {
      setNeedsLayout()
    }
  }

  private static let aspectRatio: CGFloat = 16/9

  private let imageView = RemoteImageView()

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override init(frame: CGRect) {
    super.init(frame: frame)

    self.backgroundColor = Theme.Color.background
    contentView.backgroundColor = self.backgroundColor

    contentView.addSubview(imageView)
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    let imageWidth = max(contentView.frame.width-options.contentInset.right-options.contentInset.left, 0)

    let imageHeight = max(contentView.frame.height-options.contentInset.top-options.contentInset.bottom, 0)

    imageView.frame = CGRect(x: options.contentInset.left, y: options.contentInset.top, width: imageWidth, height: imageHeight)
  }

  class func height(forWidth width: CGFloat, options: ImageCell.Options) -> CGFloat {
    let imageWidth = width - options.contentInset.right - options.contentInset.left

    let imageHeight = imageWidth / ImageCell.aspectRatio

    return options.contentInset.top + imageHeight + options.contentInset.bottom
  }
}

extension ImageCell {
  struct Options {
    let contentInset: UIEdgeInsets
  }

  static let defaultOptions = ImageCell.Options(
    contentInset: UIEdgeInsets(top: Theme.Margin.base, left: 0, bottom: Theme.Margin.base, right: 0)
  )
}
