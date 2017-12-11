import IGListKit
import UIKit

final class ArticleStreamSectionController: ListSectionController {

  private var block: ArticleStreamBlock!

  private static let titleOptions = TextCell.Options(
    font: Theme.Font.largeBold,
    textColor: Theme.Color.blue,
    contentInset: UIEdgeInsets(top: 0, left: Theme.Margin.base, bottom: Theme.Margin.small, right: Theme.Margin.base)
  )

  private static let subtitleOptions = TextCell.Options(
    font: Theme.Font.large,
    textColor: Theme.Color.text,
    contentInset: UIEdgeInsets(top: 0, left: Theme.Margin.base, bottom: Theme.Margin.base, right: Theme.Margin.base)
  )

  private static let createdOptions = TextCell.Options(
    font: Theme.Font.micro,
    textColor: Theme.Color.textLight,
    contentInset: UIEdgeInsets(top: 0, left: Theme.Margin.base, bottom: Theme.Margin.small, right: Theme.Margin.base)
  )

  private static let imageOptions = ImageCell.Options(
    contentInset: UIEdgeInsets(top: 0, left: Theme.Margin.base, bottom: Theme.Margin.base, right: Theme.Margin.base),
    aspectRatio: 16/9
  )

  override init() {
    super.init()

    inset = UIEdgeInsets(top: 0, left: 0, bottom: Theme.Margin.base, right: 0)
  }

  override func numberOfItems() -> Int {
    return 5
  }

  override func sizeForItem(at index: Int) -> CGSize {
    let width = collectionContext?.containerSize.width ?? 0

    if index == 0 {
      return CGSize(width: width, height: UserCell.preferredHeight)
    } else if index == 1 {
      let height = (block.imageUrl != nil && block.imageUrl!.count > 0) ? ImageCell.height(forWidth: width, options: ArticleStreamSectionController.imageOptions) : 0
      return CGSize(width: width, height: height)
    } else if index == 2 {
      let height = TextCell.height(forWidth: width, options: ArticleStreamSectionController.titleOptions, text: block.title)
      return CGSize(width: width, height: height)
    } else if index == 3 {
      let height = TextCell.height(forWidth: width, options: ArticleStreamSectionController.subtitleOptions, text: block.subtitle)
      return CGSize(width: width, height: height)
    } else {
      let height = TextCell.height(forWidth: width, options: ArticleStreamSectionController.createdOptions, text: DateFormatter.timeAgoString(from: block.created))
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

      cell.options = ArticleStreamSectionController.imageOptions
      cell.imageUrl = block.imageUrl

      return cell
    } else if index == 2 {
      let cell = collectionContext!.dequeueReusableCell(of: TextCell.self, for: self, at: index) as! TextCell

      cell.options = ArticleStreamSectionController.titleOptions
      cell.text = block.title

      return cell
    } else if index == 3 {
      let cell = collectionContext!.dequeueReusableCell(of: TextCell.self, for: self, at: index) as! TextCell

      cell.options = ArticleStreamSectionController.subtitleOptions
      cell.text = block.subtitle

      return cell
    } else {
      let cell = collectionContext!.dequeueReusableCell(of: TextCell.self, for: self, at: index) as! TextCell

      cell.options = ArticleStreamSectionController.createdOptions
      cell.text = DateFormatter.timeAgoString(from: block.created)

      return cell
    }
  }

  override func didUpdate(to object: Any) {
    block = (object as! ListDiffableBox<ArticleStreamBlock>).value
  }

  override func didSelectItem(at index: Int) {
    block.target?.navigate()
  }
}
