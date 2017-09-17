import UIKit

class CarouselItemCell: UICollectionViewCell {
  static let nibName = "CarouselItemCell"
  static let reuseIdentifier = "CarouselItemCell"

  @IBOutlet weak var imageView: RemoteImageView!
  @IBOutlet weak var textLabel: UILabel!

  private static let aspectRatio: CGFloat = 1 / 1

  class func nib() -> UINib {
    return UINib(nibName: CarouselItemCell.nibName, bundle: Bundle(for: CarouselItemCell.self))
  }

  class func create() -> CarouselItemCell {
    return CarouselItemCell.nib().instantiate(withOwner: self, options: nil)[0] as! CarouselItemCell
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    contentView.backgroundColor = Theme.Color.background
    textLabel.textColor = Theme.Color.text
    textLabel.font = Theme.Font.small
  }

  class func height(forWidth: CGFloat, text: String?) -> CGFloat {
    let imageHeight = (forWidth / CarouselItemCell.aspectRatio)
    let textHeight = text != nil && text!.characters.count > 0 ? Theme.Margin.tiny + 48 : 0

    return ceil(imageHeight + textHeight)
  }

  override func prepareForReuse() {
    imageView.clear()
  }
}
