import Foundation

typealias StreamServiceFactory = () -> StreamService
typealias ArticleDetailServiceFactory = () -> ArticleDetailService
typealias ImageServiceFactory = () -> ImageService

struct Services {
  static var router: Router!

  static func defaultStreamServiceFactory() -> StreamServiceFactory {
    return { StreamServiceMock() }
  }

  static func defaultArticleDetailServiceFactory() -> ArticleDetailServiceFactory {
    return { ArticleDetailServiceMock() }
  }

  static func defaultImageServiceFactory() -> ImageServiceFactory {
    return { ImageServiceDefault() }
  }

}
