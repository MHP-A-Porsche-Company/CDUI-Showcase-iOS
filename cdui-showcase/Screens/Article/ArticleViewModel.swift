import RxSwift
import RxCocoa

struct ArticleViewModel {
  let active: Variable<Bool> = Variable(false)

  var space: Driver<ArticleDetailSpace?> {
    return spaceInternal.asDriver()
  }

  private let spaceInternal: Variable<ArticleDetailSpace?> = Variable(nil)

  private let articleId: String

  private let articleDetailService: ArticleService

  private let disposeBag = DisposeBag()

  init(articleId: String,
       articleDetailServiceFactory: ArticleDetailServiceFactory = Services.defaultArticleDetailServiceFactory()) {
    self.articleId = articleId
    articleDetailService  = articleDetailServiceFactory()

    setupBindings()
  }

  private func setupBindings() {
    Observable.combineLatest(
      active.asObservable(),

      // Listen, this is obviously something you should never do, but if we edit the json serverside the changes show up instantly in the app,
      // which makes for a good demo, which is nice
      Observable<Int>.interval(2, scheduler: ConcurrentDispatchQueueScheduler(qos: .userInitiated)))

      .flatMapLatest({ (active, _) -> Observable<ArticleDetailSpace> in
        return active ? self.articleDetailService.getSpace(articleId: self.articleId) : Observable.empty()
      })
      .observeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
      .subscribe(onNext: { space in
        self.spaceInternal.value = space
      })
      .addDisposableTo(disposeBag)
  }
}
