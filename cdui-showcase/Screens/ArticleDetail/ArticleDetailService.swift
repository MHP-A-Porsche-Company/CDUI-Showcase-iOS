import RxSwift
import RxCocoa

protocol ArticleDetailService {
  func getSpace(articleId: String) -> Observable<ArticleDetailSpace>
}
