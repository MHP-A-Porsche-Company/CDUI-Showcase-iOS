import IGListKit
import UIKit

final class EmptySectionController: ListSectionController {

  override func numberOfItems() -> Int {
    return 0
  }

  override func sizeForItem(at index: Int) -> CGSize {
    return .zero
  }

  override func cellForItem(at index: Int) -> UICollectionViewCell {
    return UICollectionViewCell()
  }

  override func didUpdate(to object: Any) {
  }

  override func didSelectItem(at index: Int) {
  }
}
