import Foundation
import RxSwift
import RxCocoa

struct ArticleServiceDefault: ArticleService {
  func getSpace(articleId: String) -> Observable<ArticleDetailSpace> {
    let url = "\(Backend.baseURL)/article-\(articleId).json"
    return ObservableRequestBuilder.build(url: url)
  }
}
