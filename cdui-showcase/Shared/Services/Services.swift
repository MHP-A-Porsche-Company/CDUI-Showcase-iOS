import Foundation

typealias StreamServiceFactory = () -> StreamService
typealias ArticleDetailServiceFactory = () -> ArticleDetailService

struct Services {
//  static var router: Router!

  static func defaultStreamServiceFactory() -> StreamServiceFactory {
    return { StreamServiceMock() }
  }

  static func defaultArticleDetailServiceFactory() -> ArticleDetailServiceFactory {
    return { ArticleDetailServiceMock() }
  }

}
