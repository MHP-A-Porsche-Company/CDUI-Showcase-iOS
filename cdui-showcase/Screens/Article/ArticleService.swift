import RxSwift
import RxCocoa

protocol ArticleService {
  func getSpace(articleId: String) -> Observable<ArticleDetailSpace>
}
