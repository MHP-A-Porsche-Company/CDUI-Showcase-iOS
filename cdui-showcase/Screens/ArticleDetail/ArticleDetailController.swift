import Foundation
import UIKit
import RxSwift
import RxCocoa
import IGListKit

final class ArticleDetailController: UIViewController {

  private let aspectRatio: CGFloat = 16/9

  private var imageView: RemoteImageView!

  @IBOutlet weak var statusBarBackdrop: UIView!
  @IBOutlet weak var headerView: UIView!
  @IBOutlet weak var headerSeparator: UIView!
  @IBOutlet weak var leftHeaderButton: UIButton!

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

    collectionView.backgroundColor = .clear

    statusBarBackdrop.backgroundColor = Theme.Color.background
    headerView.backgroundColor = Theme.Color.background
    headerSeparator.backgroundColor = Theme.Color.separator

    adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    adapter.collectionView = collectionView
    adapter.dataSource = self
    adapter.scrollViewDelegate = self

    imageView = RemoteImageView()
    view.insertSubview(imageView, belowSubview: collectionView)

    updateParallax()

    collectionView.setContentOffset(CGPoint(x: 0, y: -imageView.frame.height), animated: false)

    setupBindings()
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    UIView.performWithoutAnimation {
      self.updateParallax()
    }
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    viewModel.active.value = true
  }

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)

    viewModel.active.value = false

    dch_checkDeallocation()
  }

  @IBAction func leftButtonTapped(_ sender: Any) {
    Services.router.back(from: .navigation)
  }

  private func setupBindings() {
    viewModel.space
      .drive(onNext: { [weak self] space in
        guard let strongSelf = self else { return }
        strongSelf.imageView.imageUrl = space?.header.imageUrl
        strongSelf.blocks.value = space?.blocks ?? []
      })
      .addDisposableTo(disposeBag)

    blocks.asDriver()
      .drive(onNext: { [weak self] _ in
        self?.adapter.performUpdates(animated: true, completion: nil)
      })
      .addDisposableTo(disposeBag)
  }

  private func updateParallax() {
    imageView.frame = imageViewFrame()
    collectionView.contentInset = UIEdgeInsets(top: imageView.frame.height, left: 0, bottom: 0, right: 0)
    collectionView.scrollIndicatorInsets = UIEdgeInsets(top: imageView.frame.height, left: 0, bottom: 0, right: 0)
  }

  private func imageViewFrame() -> CGRect {
    let imageHeight = view.frame.width / aspectRatio
    let offset = round(collectionView.contentOffset.y + collectionView.contentInset.top)
    let heroOffset = min(max(offset * 0.5, 0), imageHeight)

    return CGRect(x: 0, y: collectionView.frame.minY - heroOffset, width: view.frame.width, height: imageHeight)
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

extension ArticleDetailController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    imageView.frame = imageViewFrame()
  }
}
