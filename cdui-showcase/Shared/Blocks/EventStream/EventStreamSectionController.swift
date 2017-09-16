import IGListKit
import UIKit

final class EventStreamSectionController: ListSectionController {

  private var block: EventStreamBlock!

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
    let height = EventStreamCell.height(forWidth: width, title: block.title, subtitle: block.subtitle)
    return CGSize(width: width, height: height)
  }

  override func cellForItem(at index: Int) -> UICollectionViewCell {
    let cell = collectionContext!.dequeueReusableCell(of: EventStreamCell.self, for: self, at: index) as! EventStreamCell

    cell.date = DateFormatter.string(from: block.date, dateStyle: .medium).uppercased()
    cell.title = block.title
    cell.subtitle = block.subtitle

    return cell

  }

  override func didUpdate(to object: Any) {
    block = (object as! ListDiffableBox<EventStreamBlock>).value
  }

  override func didSelectItem(at index: Int) {
  }
}
