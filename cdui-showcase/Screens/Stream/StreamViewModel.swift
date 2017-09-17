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
    active.asObservable()
      .distinctUntilChanged()
      .flatMapLatest({ _ in
        return self.streamService.getSpace()
      })
      .subscribe(onNext: { space in
        self.spaceInternal.value = space
      })
      .addDisposableTo(disposeBag)
  }
}
