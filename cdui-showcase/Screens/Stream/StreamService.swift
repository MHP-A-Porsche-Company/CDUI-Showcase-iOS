import RxSwift
import RxCocoa

protocol StreamService {
  func getSpace() -> Observable<StreamSpace>
}
