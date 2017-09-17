import IGListKit
import UIKit

final class CarouselSectionController: ListSectionController {

  private var block: CarouselBlock!

  override func numberOfItems() -> Int {
    return 1
  }

  override func sizeForItem(at index: Int) -> CGSize {
    let width = collectionContext?.containerSize.width ?? 0
    let height = CarouselBlockCell.height(forWidth: width, title: block.title, items: block.items)
    return CGSize(width: width, height: height)
  }

  override func cellForItem(at index: Int) -> UICollectionViewCell {
    let cell = collectionContext!.dequeueReusableCell(of: CarouselBlockCell.self, for: self, at: index) as! CarouselBlockCell

    cell.title = block.title
    cell.items = block.items

    return cell

  }

  override func didUpdate(to object: Any) {
    block = (object as! ListDiffableBox<CarouselBlock>).value
  }

  override func didSelectItem(at index: Int) {
  }
}
