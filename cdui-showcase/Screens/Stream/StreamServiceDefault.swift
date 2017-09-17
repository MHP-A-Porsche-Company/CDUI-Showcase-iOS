import Foundation
import RxSwift
import RxCocoa

struct StreamServiceDefault: StreamService {
  func getSpace() -> Observable<StreamSpace> {
    let url = "\(Backend.baseURL)/stream.json"
    return ObservableRequestBuilder.build(url: url)
  }
}
