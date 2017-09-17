import Foundation
import RxSwift
import RxCocoa

struct ArticleDetailServiceDefault: ArticleDetailService {
  func getSpace(articleId: String) -> Observable<ArticleDetailSpace> {
    let url = "\(Backend.baseURL)/article.json"
    return ObservableRequestBuilder.build(url: url)
  }
}
