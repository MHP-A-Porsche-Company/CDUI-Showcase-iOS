import RxSwift
import RxCocoa

protocol ArticleDetailService {
  var space: Driver<ArticleDetailSpace> { get }
}
