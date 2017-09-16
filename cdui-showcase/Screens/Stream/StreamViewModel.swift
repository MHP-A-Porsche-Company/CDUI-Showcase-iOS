import RxSwift
import RxCocoa

struct StreamViewModel {
  let active: Variable<Bool> = Variable(false)

  var space: Driver<StreamSpace> {
    return streamService.space
  }

  private let streamService: StreamService

  init(streamServiceFactory: StreamServiceFactory = Services.defaultStreamServiceFactory()) {
    streamService  = streamServiceFactory()
  }
}
