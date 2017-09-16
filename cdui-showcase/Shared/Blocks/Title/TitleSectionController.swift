import IGListKit
import UIKit

final class TitleSectionController: ListSectionController {

  private var block: TitleBlock!

  private static let textCellOptions = TextCell.Options(
    font: Theme.Font.largeBold,
    textColor: Theme.Color.text,
    contentInset: UIEdgeInsets(top: Theme.Margin.base, left: Theme.Margin.base, bottom: Theme.Margin.base, right: Theme.Margin.base)
  )

  override func numberOfItems() -> Int {
    return 1
  }

  override func sizeForItem(at index: Int) -> CGSize {
    let width = collectionContext?.containerSize.width ?? 0
    let height = TextCell.height(forWidth: width, options: TitleSectionController.textCellOptions, text: block.text)
    return CGSize(width: width, height: height)
  }

  override func cellForItem(at index: Int) -> UICollectionViewCell {
    let cell = collectionContext!.dequeueReusableCell(of: TextCell.self, for: self, at: index) as! TextCell

    cell.options = TitleSectionController.textCellOptions
    cell.text = block.text

    return cell

  }

  override func didUpdate(to object: Any) {
    block = (object as! ListDiffableBox<TitleBlock>).value
  }

  override func didSelectItem(at index: Int) {
  }
}
