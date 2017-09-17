import IGListKit
import UIKit

final class TextSectionController: ListSectionController {

  private var block: TextBlock!

  private static let textCellOptions = TextCell.Options(
    font: Theme.Font.base,
    textColor: Theme.Color.text,
    lineSpacing: Theme.LineSpacing.wide,
    contentInset: UIEdgeInsets(top: Theme.Margin.small, left: Theme.Margin.base, bottom: Theme.Margin.small, right: Theme.Margin.base)
  )

  override func numberOfItems() -> Int {
    return 1
  }

  override func sizeForItem(at index: Int) -> CGSize {
    let width = collectionContext?.containerSize.width ?? 0
    let height = TextCell.height(forWidth: width, options: TextSectionController.textCellOptions, text: block.text)
    return CGSize(width: width, height: height)
  }

  override func cellForItem(at index: Int) -> UICollectionViewCell {
    let cell = collectionContext!.dequeueReusableCell(of: TextCell.self, for: self, at: index) as! TextCell

    cell.options = TextSectionController.textCellOptions
    cell.text = block.text

    return cell

  }

  override func didUpdate(to object: Any) {
    block = (object as! ListDiffableBox<TextBlock>).value
  }

  override func didSelectItem(at index: Int) {
  }
}
