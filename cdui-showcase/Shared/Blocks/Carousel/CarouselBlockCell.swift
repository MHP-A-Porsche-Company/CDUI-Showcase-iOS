import Foundation
import UIKit
import IGListKit

class CarouselBlockCell: UICollectionViewCell {
  static let reuseIdentifier: String = "CarouselBlockCell"

  static let relativeElementWidth: CGFloat = 0.5

  var title: String? {
    didSet {
      titleLabel.text = title
    }
  }

  var items: [CarouselItem] = [] {
    didSet {
      collectionView.reloadData()
    }
  }

  private var titleLabel: UILabel!
  private var layout: UICollectionViewFlowLayout!
  private var collectionView: UICollectionView!
  private var adapter: ListAdapter!

  private static let topMargin: CGFloat = Theme.Margin.base
  private static let titleLabelHeight: CGFloat = 24
  private static let titleLabelMargin: CGFloat = Theme.Margin.base
  private static let bottomMargin: CGFloat = Theme.Margin.base

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override init(frame: CGRect) {
    super.init(frame: frame)

    clipsToBounds = true
    backgroundColor = Theme.Color.background
    contentView.backgroundColor = Theme.Color.background

    titleLabel = UILabel()
    titleLabel.font = Theme.Font.large
    titleLabel.textColor = Theme.Color.text
    titleLabel.backgroundColor = Theme.Color.background
    contentView.addSubview(titleLabel)

    layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.sectionInset = UIEdgeInsets(top: 0, left: Theme.Margin.base, bottom: 0, right: Theme.Margin.base)
    layout.minimumInteritemSpacing = 0
    layout.minimumLineSpacing = Theme.Margin.small

    collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
    collectionView.backgroundColor = Theme.Color.background
    collectionView.alwaysBounceVertical = false
    collectionView.alwaysBounceHorizontal = true
    collectionView.showsVerticalScrollIndicator = false
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.decelerationRate = UIScrollViewDecelerationRateFast
    collectionView.dataSource = self

    collectionView.register(CarouselItemCell.nib(), forCellWithReuseIdentifier: CarouselItemCell.reuseIdentifier)

    contentView.addSubview(collectionView)
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    let titleHeight = title != nil && title!.characters.count > 0 ? CarouselBlockCell.titleLabelHeight : 0
    let titleMargin = titleHeight > 0 ? CarouselBlockCell.titleLabelMargin : 0

    let elementWidth = CarouselBlockCell.elementWidth(forWidth: collectionView.frame.width)
    let elementHeight = CarouselBlockCell.maxElementHeight(forWidth: elementWidth, items: items)

    titleLabel.frame = CGRect(x: Theme.Margin.base, y: CarouselBlockCell.topMargin, width: contentView.frame.width - 2*Theme.Margin.base, height: titleHeight)

    collectionView.frame = CGRect(x: 0, y: CarouselBlockCell.topMargin + titleHeight + titleMargin, width: contentView.frame.width, height: elementHeight)
    layout.itemSize = CGSize(width: CarouselBlockCell.elementWidth(forWidth: collectionView.frame.width), height: collectionView.frame.height)
  }

  class func height(forWidth: CGFloat, title: String?, items: [CarouselItem]) -> CGFloat {
    let titleHeight = title != nil && title!.characters.count > 0 ? titleLabelHeight + titleLabelMargin : 0

    let elementWidth = CarouselBlockCell.elementWidth(forWidth: forWidth)
    let elementHeight = CarouselBlockCell.maxElementHeight(forWidth: elementWidth, items: items)

    return topMargin + titleHeight + elementHeight + bottomMargin
  }

  class func maxElementHeight(forWidth width: CGFloat, items: [CarouselItem]) -> CGFloat {
    return items.reduce(0, { (result, item) in
      let height = CarouselItemCell.height(forWidth: width, text: item.text)
      return height > result ? height : result
    })
  }

  class func elementWidth(forWidth: CGFloat) -> CGFloat {
    let itemWidth = (forWidth - 2*Theme.Margin.base - Theme.Margin.small) * CarouselBlockCell.relativeElementWidth
    return max(itemWidth, 100)
  }
}

extension CarouselBlockCell: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return items.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselItemCell.reuseIdentifier, for: indexPath) as! CarouselItemCell

    let item = items[indexPath.row]

    cell.textLabel.text = item.text
    cell.imageView.load(imageUrl: item.imageUrl)

    return cell
  }
}
