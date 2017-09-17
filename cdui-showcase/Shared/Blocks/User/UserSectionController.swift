import IGListKit
import UIKit

final class UserSectionController: ListSectionController {

  private var block: UserBlock!

  override func numberOfItems() -> Int {
    return 1
  }

  override func sizeForItem(at index: Int) -> CGSize {
    let width = collectionContext?.containerSize.width ?? 0
    let height = UserCell.preferredHeight
    return CGSize(width: width, height: height)
  }

  override func cellForItem(at index: Int) -> UICollectionViewCell {
    let cell = collectionContext!.dequeueReusableCell(withNibName: UserCell.nibName, bundle: nil, for: self, at: index) as! UserCell

    cell.imageUrl = block.user.imageUrl
    cell.title = block.user.name
    cell.subtitle = block.user.position

    return cell

  }

  override func didUpdate(to object: Any) {
    block = (object as! ListDiffableBox<UserBlock>).value
  }

  override func didSelectItem(at index: Int) {
  }
}
