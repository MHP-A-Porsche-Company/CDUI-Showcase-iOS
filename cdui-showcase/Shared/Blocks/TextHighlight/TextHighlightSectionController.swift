import IGListKit
import UIKit

final class TextHighlightSectionController: ListSectionController {

  private var block: TextHighlightBlock!

  private static let textCellOptions = TextCell.Options(
    font: Theme.Font.largeBold,
    textColor: Theme.Color.blue,
    lineSpacing: Theme.LineSpacing.wide,
    contentInset: UIEdgeInsets(top: Theme.Margin.base, left: Theme.Margin.large, bottom: Theme.Margin.base, right: Theme.Margin.base)
  )

  override func numberOfItems() -> Int {
    return 1
  }

  override func sizeForItem(at index: Int) -> CGSize {
    let width = collectionContext?.containerSize.width ?? 0
    let height = TextCell.height(forWidth: width, options: TextHighlightSectionController.textCellOptions, text: block.text)
    return CGSize(width: width, height: height)
  }

  override func cellForItem(at index: Int) -> UICollectionViewCell {
    let cell = collectionContext!.dequeueReusableCell(of: TextCell.self, for: self, at: index) as! TextCell

    cell.options = TextHighlightSectionController.textCellOptions
    cell.text = block.text

    return cell

  }

  override func didUpdate(to object: Any) {
    block = (object as! ListDiffableBox<TextHighlightBlock>).value
  }

  override func didSelectItem(at index: Int) {
  }
}
