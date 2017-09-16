import IGListKit
import UIKit

final class ImageStreamSectionController: ListSectionController {

  private var block: ImageStreamBlock!

  private static let textCellOptions = TextCell.Options(
    font: Theme.Font.largeBold,
    textColor: Theme.Color.text,
    contentInset: UIEdgeInsets(top: Theme.Margin.base, left: Theme.Margin.base, bottom: Theme.Margin.base, right: Theme.Margin.base)
  )

  override init() {
    super.init()

    inset = UIEdgeInsets(top: 0, left: 0, bottom: Theme.Margin.base, right: 0)
  }

  override func numberOfItems() -> Int {
    return 1
  }

  override func sizeForItem(at index: Int) -> CGSize {
    let width = collectionContext?.containerSize.width ?? 0
    let height = TextCell.height(forWidth: width, options: ImageStreamSectionController.textCellOptions, text: block.user.name)
    return CGSize(width: width, height: height)
  }

  override func cellForItem(at index: Int) -> UICollectionViewCell {
    let cell = collectionContext!.dequeueReusableCell(of: TextCell.self, for: self, at: index) as! TextCell

    cell.options = ImageStreamSectionController.textCellOptions
    cell.text = block.user.name

    return cell

  }

  override func didUpdate(to object: Any) {
    block = (object as! ListDiffableBox<ImageStreamBlock>).value
  }

  override func didSelectItem(at index: Int) {
  }
}
