import Foundation

typealias StreamServiceFactory = () -> StreamService
typealias ArticleDetailServiceFactory = () -> ArticleService
typealias ImageServiceFactory = () -> ImageService

struct Services {
  static var router: Router!

  static func defaultStreamServiceFactory() -> StreamServiceFactory {
    return { StreamServiceDefault() }
  }

  static func defaultArticleDetailServiceFactory() -> ArticleDetailServiceFactory {
    return { ArticleServiceDefault() }
  }

  static func defaultImageServiceFactory() -> ImageServiceFactory {
    return { ImageServiceDefault() }
  }

}
