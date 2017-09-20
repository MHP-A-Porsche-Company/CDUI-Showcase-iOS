import UIKit

struct ArticleDetailRouteParams: RouteParams {
  let articleId: String
}

struct ArticleDetailRouteFactory: RouteFactory {
  func params(from url: URL) throws -> RouteParams? {
    let components = URLComponents(url: url, resolvingAgainstBaseURL: false)

    guard let articleId = components?.queryItems?.first(where: { $0.name == "id" })?.value else {
      throw RouteFactoryError.QueryParameterError("Can not create article space params using \(url). ArticleId is missing")
    }

    return ArticleDetailRouteParams(articleId: articleId)
  }

  func build(with params: RouteParams?) throws -> UIViewController {
    guard let params = params as? ArticleDetailRouteParams else {
      throw RouteFactoryError.ParameterError("Can not route to article detail. Wrong params provided.")
    }

    let viewModel = ArticleViewModel(articleId: params.articleId)
    let controller = ArticleController.create(viewModel: viewModel)

    return controller
  }
}
