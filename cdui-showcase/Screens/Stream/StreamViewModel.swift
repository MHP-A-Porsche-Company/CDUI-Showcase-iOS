import RxSwift
import RxCocoa

struct StreamViewModel {
  let active: Variable<Bool> = Variable(false)

  var space: Driver<StreamSpace?> {
    return spaceInternal.asDriver()
  }

  private let spaceInternal: Variable<StreamSpace?> = Variable(nil)

  private let streamService: StreamService

  private let disposeBag = DisposeBag()

  init(streamServiceFactory: StreamServiceFactory = Services.defaultStreamServiceFactory()) {
    streamService  = streamServiceFactory()
    setupBindings()
  }

  private func setupBindings() {
    Observable.combineLatest(
      active.asObservable(),

      // Listen, this is obviously something you should never do, but if we edit the json serverside the changes show up instantly in the app,
      // which makes for a good demo, which is nice
      Observable<Int>.interval(2, scheduler: ConcurrentDispatchQueueScheduler(qos: .userInitiated)))

      .flatMapLatest({ (active, _) -> Observable<StreamSpace> in
        return active ? self.streamService.getSpace() : Observable.empty()
      })
      .observeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
      .subscribe(onNext: { space in
        self.spaceInternal.value = space
      })
      .addDisposableTo(disposeBag)
  }
}
