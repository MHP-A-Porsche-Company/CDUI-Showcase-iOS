import Foundation
import UIKit
import RxSwift
import RxCocoa
import IGListKit

final class StreamController: UIViewController {

  @IBOutlet weak var headerView: UIView!
  @IBOutlet weak var headerLabel: UILabel!
  @IBOutlet weak var collectionView: UICollectionView!

  private (set) var adapter: ListAdapter!

  private var viewModel: StreamViewModel!

  private let blocks: Variable<[Block]> = Variable([])

  private let disposeBag = DisposeBag()

  class func create(viewModel: StreamViewModel) -> StreamController {
    let storyboard = UIStoryboard(name: "Stream", bundle: nil)
    let viewController = storyboard.instantiateInitialViewController() as! StreamController
    viewController.viewModel = viewModel
    return viewController
  }

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = Theme.Color.blue

    headerView.backgroundColor = Theme.Color.blue
    headerLabel.backgroundColor = Theme.Color.blue
    headerLabel.font = Theme.Font.baseBold
    headerLabel.textColor = Theme.Color.textInvert
    headerLabel.textAlignment = .center

    collectionView.backgroundColor = Theme.Color.greyLight

    adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    adapter.collectionView = collectionView
    adapter.dataSource = self

    setupBindings()
  }

  private func setupBindings() {
    viewModel.space
      .drive(onNext: { [weak self] space in
        guard let strongSelf = self else { return }
        strongSelf.headerLabel.text = space.header.title
        strongSelf.blocks.value = space.blocks
      })
      .addDisposableTo(disposeBag)

    blocks.asDriver()
      .drive(onNext: { [weak self] _ in
        self?.adapter.performUpdates(animated: true, completion: nil)
      })
      .addDisposableTo(disposeBag)
  }
}

extension StreamController: ListAdapterDataSource {
  func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
    return blocks.value.map({ $0.listDiffable })
  }

  func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
    return BlockSectionControllerFactory.sectionController(for: object)
  }

  func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }
}
