import IGListKit
import UIKit

final class ArticleHeaderSectionController: ListSectionController {

  private var block: ArticleHeaderBlock!

  private static let titleOptions = TextCell.Options(
    font: Theme.Font.largeBold,
    textColor: Theme.Color.blue,
    contentInset: UIEdgeInsets(top: Theme.Margin.base, left: Theme.Margin.base, bottom: Theme.Margin.small, right: Theme.Margin.base)
  )

  private static let subtitleOptions = TextCell.Options(
    font: Theme.Font.large,
    textColor: Theme.Color.text,
    contentInset: UIEdgeInsets(top: 0, left: Theme.Margin.base, bottom: Theme.Margin.small, right: Theme.Margin.base)
  )

  override func numberOfItems() -> Int {
    return 2
  }

  override func sizeForItem(at index: Int) -> CGSize {
    let width = collectionContext?.containerSize.width ?? 0

    if index == 0 {
      let height = TextCell.height(forWidth: width, options: ArticleHeaderSectionController.titleOptions, text: block.title)
      return CGSize(width: width, height: height)
    } else {
      let height = TextCell.height(forWidth: width, options: ArticleHeaderSectionController.subtitleOptions, text: block.subtitle)
      return CGSize(width: width, height: height)
    }
  }

  override func cellForItem(at index: Int) -> UICollectionViewCell {
    if index == 0 {
      let cell = collectionContext!.dequeueReusableCell(of: TextCell.self, for: self, at: index) as! TextCell

      cell.options = ArticleHeaderSectionController.titleOptions
      cell.text = block.title

      return cell
    } else {
      let cell = collectionContext!.dequeueReusableCell(of: TextCell.self, for: self, at: index) as! TextCell

      cell.options = ArticleHeaderSectionController.subtitleOptions
      cell.text = block.subtitle

      return cell
    }
  }

  override func didUpdate(to object: Any) {
    block = (object as! ListDiffableBox<ArticleHeaderBlock>).value
  }

  override func didSelectItem(at index: Int) {
  }
}
