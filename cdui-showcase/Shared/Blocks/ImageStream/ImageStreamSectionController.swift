import IGListKit
import UIKit

final class ImageStreamSectionController: ListSectionController {

  private var block: ImageStreamBlock!

  private static let imageOptions = ImageCell.Options(
    contentInset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
    aspectRatio: 1
  )

  private static let createdOptions = TextCell.Options(
    font: Theme.Font.micro,
    textColor: Theme.Color.textLight,
    contentInset: UIEdgeInsets(top: Theme.Margin.small, left: Theme.Margin.base, bottom: Theme.Margin.small, right: Theme.Margin.base)
  )

  override init() {
    super.init()

    inset = UIEdgeInsets(top: 0, left: 0, bottom: Theme.Margin.base, right: 0)
  }

  override func numberOfItems() -> Int {
    return 3
  }

  override func sizeForItem(at index: Int) -> CGSize {
    let width = collectionContext?.containerSize.width ?? 0

    if index == 0 {
      return CGSize(width: width, height: UserCell.preferredHeight)
    } else if index == 1 {
      let height = ImageCell.height(forWidth: width, options: ImageStreamSectionController.imageOptions)
      return CGSize(width: width, height: height)
    } else {
      let height = TextCell.height(forWidth: width, options: ImageStreamSectionController.createdOptions, text: DateFormatter.timeAgoString(from: block.created))
      return CGSize(width: width, height: height)
    }
  }

  override func cellForItem(at index: Int) -> UICollectionViewCell {
    if index == 0 {
      let cell = collectionContext!.dequeueReusableCell(withNibName: UserCell.nibName, bundle: nil, for: self, at: index) as! UserCell

      cell.imageUrl = block.user.imageUrl
      cell.title = block.user.name
      cell.subtitle = block.user.position

      return cell
    } else if index == 1 {
      let cell = collectionContext!.dequeueReusableCell(of: ImageCell.self, for: self, at: index) as! ImageCell

      cell.options = ImageStreamSectionController.imageOptions
      cell.imageUrl = block.imageUrl

      return cell
    } else {
      let cell = collectionContext!.dequeueReusableCell(of: TextCell.self, for: self, at: index) as! TextCell

      cell.options = ImageStreamSectionController.createdOptions
      cell.text = DateFormatter.timeAgoString(from: block.created)

      return cell
    }
  }

  override func didUpdate(to object: Any) {
    block = (object as! ListDiffableBox<ImageStreamBlock>).value
  }

  override func didSelectItem(at index: Int) {
  }
}
