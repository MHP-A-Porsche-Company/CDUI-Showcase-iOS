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

    collectionView.backgroundColor = Theme.Color.background

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
    // TODO: Make this into a factory
    switch object {
//    case _ as ListDiffableBox<TitleBlock>:
//      let section = TitleSectionController()
//      return section
//    case _ as ListDiffableBox<LargeTitleBlock>:
//      let section = LargeTitleSectionController()
//      return section
//    case _ as ListDiffableBox<TextBlock>:
//      let section = TextSectionController()
//      return section
//    case _ as ListDiffableBox<WhitespaceBlock>:
//      let section = WhitespaceSectionController()
//      return section
//    case _ as ListDiffableBox<SeparatorBlock>:
//      let section = SeparatorSectionController()
//      return section
//    case _ as ListDiffableBox<ArticleSectionDiffable>:
//      let section = ArticleSectionController(imageService: blockViewModel.imageService)
//      return section
//    case _ as ListDiffableBox<CarouselBlock>:
//      let section = CarouselSectionController(imageService: blockViewModel.imageService)
//      return section
//    case _ as ListDiffableBox<HeroBlock>:
//      let section = HeroSectionController(imageService: blockViewModel.imageService)
//      return section
//    case _ as ListDiffableBox<ListElementBlock>:
//      let section = ListElementSectionController()
//      return section
//    case _ as ListDiffableBox<ImageListElementBlock>:
//      let section = ImageListElementSectionController(imageService: blockViewModel.imageService)
//      return section
//    case _ as ListDiffableBox<ListPreviewBlock>:
//      let section = ListPreviewSectionController(imageService: blockViewModel.imageService)
//      return section
    default:
      print("Encountered block with unexpected type \(object) in \(type(of: self)).")
      return EmptySectionController()
    }
  }

  func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }
}
