import Foundation

typealias StreamServiceFactory = () -> StreamService
typealias ArticleDetailServiceFactory = () -> ArticleDetailService
typealias ImageServiceFactory = () -> ImageService

struct Services {
  static var router: Router!

  static func defaultStreamServiceFactory() -> StreamServiceFactory {
    return { StreamServiceDefault() }
  }

  static func defaultArticleDetailServiceFactory() -> ArticleDetailServiceFactory {
    return { ArticleDetailServiceDefault() }
  }

  static func defaultImageServiceFactory() -> ImageServiceFactory {
    return { ImageServiceDefault() }
  }

}
