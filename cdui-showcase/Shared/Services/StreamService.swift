import RxSwift
import RxCocoa

protocol StreamService {
  var space: Driver<StreamSpace> { get }
}
