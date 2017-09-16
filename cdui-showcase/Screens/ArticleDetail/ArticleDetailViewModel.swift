import RxSwift
import RxCocoa

struct ArticleDetailViewModel {
  let active: Variable<Bool> = Variable(false)

  var space: Driver<ArticleDetailSpace> {
    return articleDetailService.space
  }

  private let articleDetailService: ArticleDetailService

  init(articleDetailServiceFactory: ArticleDetailServiceFactory = Services.defaultArticleDetailServiceFactory()) {
    articleDetailService  = articleDetailServiceFactory()
  }
}
