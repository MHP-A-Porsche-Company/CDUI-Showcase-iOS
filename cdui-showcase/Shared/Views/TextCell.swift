import Foundation
import UIKit

class TextCell: UICollectionViewCell {
  static let reuseIdentifier: String = "TextCell"

  var text: String? {
    didSet {
      textLabel.attributedText = TextCell.attributedText(with: text, options: options)
      setNeedsLayout()
    }
  }
  // Implementation...
  var options = TextCell.Options() {
    didSet {
      textLabel.attributedText = TextCell.attributedText(with: text, options: options)
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

    let labelWidth = max(contentView.frame.width-options.contentInset.right-options.contentInset.left, 0)

    let labelHeight = max(contentView.frame.height-options.contentInset.top-options.contentInset.bottom, 0)

    textLabel.frame = CGRect(x: options.contentInset.left, y: options.contentInset.top, width: labelWidth, height: labelHeight)
  }

  static func attributedText(with text: String?, options: TextCell.Options) -> NSAttributedString {
    let paragraph = NSMutableParagraphStyle()
    paragraph.lineSpacing = options.lineSpacing

    return NSAttributedString(string: text ?? "", attributes: [
      NSAttributedStringKey.font: options.font,
      NSAttributedStringKey.foregroundColor: options.textColor,
      NSAttributedStringKey.paragraphStyle: paragraph])
  }

  class func height(forWidth: CGFloat, options: TextCell.Options, text: String?) -> CGFloat {
    guard let text = text, text.count > 0 else {
      return 0

    }

    let labelWidth = forWidth-options.contentInset.right-options.contentInset.left

    let textHeight = TextCell.attributedText(with: text, options: options).heightWithConstrainedWidth(width: labelWidth)

    return options.contentInset.top + textHeight + options.contentInset.bottom
  }
}

extension TextCell {
  struct Options {
    let font: UIFont
    let textColor: UIColor
    let lineSpacing: CGFloat
    let contentInset: UIEdgeInsets

    init(font: UIFont = Theme.Font.base,
         textColor: UIColor = Theme.Color.text,
         lineSpacing: CGFloat = Theme.LineSpacing.base,
         contentInset: UIEdgeInsets = UIEdgeInsets(top: Theme.Margin.base, left: Theme.Margin.base, bottom: Theme.Margin.base, right: Theme.Margin.base)) {
      self.font = font
      self.textColor = textColor
      self.lineSpacing = lineSpacing
      self.contentInset = contentInset
    }
  }
}
