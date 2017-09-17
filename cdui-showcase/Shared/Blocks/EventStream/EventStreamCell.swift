import UIKit

final class EventStreamCell: UICollectionViewCell {
  static let reuseIdentifier: String = "EventStreamCell"

  var date: String? {
    didSet {
      dateLabel.text = date
    }
  }

  var title: String? {
    didSet {
      titleLabel.attributedText = EventStreamCell.attributedTitle(title)
      setNeedsLayout()
    }
  }

  var subtitle: String? {
    didSet {
      subtitleLabel.attributedText = EventStreamCell.attributedSubtitle(subtitle)
      setNeedsLayout()
    }
  }

  private let eventLabel = UILabel()
  private let dateLabel = UILabel()
  private let titleLabel = UILabel()
  private let subtitleLabel = UILabel()
  private let gradient = GradientView()

  static private let marginTop: CGFloat = Theme.Margin.base
  static private let marginBottom: CGFloat = Theme.Margin.base
  static private let marginSide: CGFloat = Theme.Margin.base

  static private let eventLabelHeight: CGFloat = 20
  static private let dateLabelHeight: CGFloat = 20
  static private let titleLabelMarginTop: CGFloat = Theme.Margin.base
  static private let labelMargin: CGFloat = Theme.Margin.small

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  private func setup() {
    gradient.diagonalMode = true
    gradient.horizontalMode = true
    gradient.startColor = UIColor(hex: "#0000F6")
    gradient.endColor = UIColor(hex: "#1F1F80")
    gradient.startLocation = 0.05
    gradient.endLocation = 0.8
    contentView.addSubview(gradient)

    eventLabel.textColor = Theme.Color.textInvert
    eventLabel.font = Theme.Font.smallBold
    eventLabel.numberOfLines = 1
    eventLabel.text = "Veranstaltung"
    contentView.addSubview(eventLabel)

    dateLabel.textColor = Theme.Color.textInvert
    dateLabel.font = Theme.Font.micro
    dateLabel.numberOfLines = 1
    contentView.addSubview(dateLabel)

    titleLabel.numberOfLines = 0
    contentView.addSubview(titleLabel)

    subtitleLabel.numberOfLines = 0
    contentView.addSubview(subtitleLabel)
  }

  class func height(forWidth width: CGFloat, title: String, subtitle: String) -> CGFloat {
    let labelWidth = width - 2*EventStreamCell.marginSide

    let titleHeight = EventStreamCell.getHeight(forWidth: labelWidth, title: title)
    let subtitleHeight = EventStreamCell.getHeight(forWidth: labelWidth, subtitle: subtitle)
    let labelMargin = titleHeight > 0 && subtitleHeight > 0 ? EventStreamCell.labelMargin : 0

    return EventStreamCell.marginTop
      + EventStreamCell.eventLabelHeight
      + EventStreamCell.dateLabelHeight
      + EventStreamCell.titleLabelMarginTop
      + titleHeight
      + labelMargin
      + subtitleHeight
      + EventStreamCell.marginBottom
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    let labelX = Theme.Margin.base
    let labelWidth = frame.width - 2*EventStreamCell.marginSide

    let titleHeight = EventStreamCell.getHeight(forWidth: labelWidth, title: titleLabel.text ?? "")
    let subtitleHeight = EventStreamCell.getHeight(forWidth: labelWidth, subtitle: subtitleLabel.text ?? "")
    let labelMargin = titleHeight > 0 && subtitleHeight > 0 ? EventStreamCell.labelMargin : 0

    gradient.frame = contentView.bounds

    eventLabel.frame = CGRect(x: labelX, y: EventStreamCell.marginTop, width: labelWidth, height: EventStreamCell.eventLabelHeight)
    dateLabel.frame = CGRect(x: labelX, y: eventLabel.frame.maxY, width: labelWidth, height: EventStreamCell.dateLabelHeight)

    titleLabel.frame = CGRect(x: labelX, y: dateLabel.frame.maxY + EventStreamCell.titleLabelMarginTop, width: labelWidth, height: titleHeight)
    subtitleLabel.frame = CGRect(x: labelX, y: titleLabel.frame.maxY + labelMargin, width: labelWidth, height: subtitleHeight)
  }

  override func prepareForReuse() {
    dateLabel.text = ""
    titleLabel.text = ""
    subtitleLabel.text = ""
  }

  private static func attributedTitle(_ title: String?) -> NSAttributedString {
    let paragraph = NSMutableParagraphStyle()
    paragraph.lineSpacing = Theme.LineSpacing.base

    return NSAttributedString(string: title ?? "", attributes: [
      NSAttributedStringKey.font: Theme.Font.largeBold,
      NSAttributedStringKey.foregroundColor: Theme.Color.background,
      NSAttributedStringKey.paragraphStyle: paragraph])
  }

  private static func getHeight(forWidth width: CGFloat, title: String) -> CGFloat {
    let titleHeight: CGFloat

    if title.characters.count > 0 {
      titleHeight = attributedTitle(title).heightWithConstrainedWidth(width: width)
    } else {
      titleHeight = 0
    }

    return titleHeight
  }

  private static func attributedSubtitle(_ subtitle: String?) -> NSAttributedString {
    let paragraph = NSMutableParagraphStyle()
    paragraph.lineSpacing = Theme.LineSpacing.base

    return NSAttributedString(string: subtitle ?? "", attributes: [
      NSAttributedStringKey.font: Theme.Font.large,
      NSAttributedStringKey.foregroundColor: Theme.Color.textInvert.withAlphaComponent(0.66),
      NSAttributedStringKey.paragraphStyle: paragraph])
  }

  private static func getHeight(forWidth width: CGFloat, subtitle: String) -> CGFloat {
    let subtitleHeight: CGFloat

    if subtitle.characters.count > 0 {
      subtitleHeight = attributedSubtitle(subtitle).heightWithConstrainedWidth(width: width)
    } else {
      subtitleHeight = 0
    }

    return subtitleHeight
  }
}
