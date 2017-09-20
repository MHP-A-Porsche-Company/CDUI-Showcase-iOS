import IGListKit
import UIKit

final class ImageSectionController: ListSectionController {

  private var block: ImageBlock!

  private static let imageOptions = ImageCell.Options(
    contentInset: UIEdgeInsets(top: Theme.Margin.base, left: 0, bottom: Theme.Margin.base, right: 0),
    aspectRatio: 16/9
  )

  override func numberOfItems() -> Int {
    return 1
  }

  override func sizeForItem(at index: Int) -> CGSize {
    let width = collectionContext?.containerSize.width ?? 0
    let height = ImageCell.height(forWidth: width, options: ImageSectionController.imageOptions)
    return CGSize(width: width, height: height)
  }

  override func cellForItem(at index: Int) -> UICollectionViewCell {
    let cell = collectionContext!.dequeueReusableCell(of: ImageCell.self, for: self, at: index) as! ImageCell

    cell.options = ImageSectionController.imageOptions
    cell.imageUrl = block.imageUrl

    return cell

  }

  override func didUpdate(to object: Any) {
    block = (object as! ListDiffableBox<ImageBlock>).value
  }

  override func didSelectItem(at index: Int) {
  }
}
