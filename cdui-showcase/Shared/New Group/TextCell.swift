import Foundation
import UIKit

class TextCell: UICollectionViewCell {
  static let reuseIdentifier: String = "TextCell"

  var text: String? {
    didSet {
      textLabel.text = text
      setNeedsLayout()
    }
  }

  var options = TextCell.defaultOptions {
    didSet {
      textLabel.font = options.font
      textLabel.textColor = options.textColor
      setNeedsLayout()
    }
  }

  private let textLabel = UILabel()

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override init(frame: CGRect) {
    super.init(frame: frame)

    self.backgroundColor = Theme.Color.background
    contentView.backgroundColor = self.backgroundColor

    textLabel.font = options.font
    textLabel.textColor = Theme.Color.text
    textLabel.backgroundColor = Theme.Color.background
    textLabel.numberOfLines = 0
    contentView.addSubview(textLabel)
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    let labelWidth = contentView.frame.width-options.contentInset.right-options.contentInset.left

    let textHeight = text?.heightWithConstrainedWidth(width: labelWidth, font: options.font) ?? 0
    textLabel.frame = CGRect(x: options.contentInset.left, y: options.contentInset.top, width: labelWidth, height: textHeight)
  }

  class func height(forWidth: CGFloat, options: TextCell.Options, text: String?) -> CGFloat {
    guard let text = text, text.characters.count > 0 else {
      return 0

    }

    let labelWidth = forWidth-options.contentInset.right-options.contentInset.left

    let textHeight = text.heightWithConstrainedWidth(width: labelWidth, font: options.font)

    return options.contentInset.top + textHeight + options.contentInset.bottom
  }
}

extension TextCell {
  struct Options {
    let font: UIFont
    let textColor: UIColor
    let contentInset: UIEdgeInsets
  }

  static let defaultOptions = TextCell.Options(
    font: Theme.Font.base,
    textColor: Theme.Color.text,
    contentInset: UIEdgeInsets(top: Theme.Margin.base, left: Theme.Margin.base, bottom: Theme.Margin.base, right: Theme.Margin.base)
  )
}
