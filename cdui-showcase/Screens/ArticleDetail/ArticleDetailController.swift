import Foundation
import UIKit
import RxSwift
import RxCocoa
import IGListKit

final class ArticleDetailController: UIViewController {

  @IBOutlet private weak var collectionView: UICollectionView!

  private (set) var adapter: ListAdapter!

  private var viewModel: ArticleDetailViewModel!

  private let blocks: Variable<[Block]> = Variable([])

  private let disposeBag = DisposeBag()

  class func create(viewModel: ArticleDetailViewModel) -> ArticleDetailController {
    let storyboard = UIStoryboard(name: "ArticleDetail", bundle: nil)
    let viewController = storyboard.instantiateInitialViewController() as! ArticleDetailController
    viewController.viewModel = viewModel
    return viewController
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = Theme.Color.background

    collectionView.backgroundColor = Theme.Color.greyLighter

    adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    adapter.collectionView = collectionView
    adapter.dataSource = self

    setupBindings()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    viewModel.active.value = true
  }

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)

    viewModel.active.value = false
  }

  private func setupBindings() {
    viewModel.space
      .drive(onNext: { [weak self] space in
        guard let strongSelf = self else { return }
        strongSelf.blocks.value = space?.blocks ?? []
      })
      .addDisposableTo(disposeBag)

    blocks.asDriver()
      .drive(onNext: { [weak self] _ in
        self?.adapter.performUpdates(animated: true, completion: nil)
      })
      .addDisposableTo(disposeBag)
  }
}

extension ArticleDetailController: ListAdapterDataSource {
  func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
    return blocks.value.map({ $0.listDiffable })
  }

  func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
    return BlockSectionControllerFactory.sectionController(for: object)
  }

  func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }
}
