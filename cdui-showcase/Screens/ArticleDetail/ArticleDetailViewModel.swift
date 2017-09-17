import RxSwift
import RxCocoa

struct ArticleDetailViewModel {
  let active: Variable<Bool> = Variable(false)

  var space: Driver<ArticleDetailSpace?> {
    return spaceInternal.asDriver()
  }

  private let spaceInternal: Variable<ArticleDetailSpace?> = Variable(nil)

  private let articleId: String

  private let articleDetailService: ArticleDetailService

  private let disposeBag = DisposeBag()

  init(articleId: String,
       articleDetailServiceFactory: ArticleDetailServiceFactory = Services.defaultArticleDetailServiceFactory()) {
    self.articleId = articleId
    articleDetailService  = articleDetailServiceFactory()

    setupBindings()
  }

  private func setupBindings() {
    active.asObservable()
      .distinctUntilChanged()
      .flatMapLatest({ _ in
        return self.articleDetailService.getSpace(articleId: self.articleId)
      })
      .subscribe(onNext: { space in
        self.spaceInternal.value = space
      })
      .addDisposableTo(disposeBag)
  }
}
