import UIKit

struct ArticleDetailRouteParams: RouteParams {
  let articleId: String
}

struct ArticleDetailRouteFactory: RouteFactory {
  func params(from: URL) -> RouteParams? {
    return ArticleDetailRouteParams(articleId: "123")
  }

  func build(params: RouteParams?) throws -> UIViewController {
    guard let params = params as? ArticleDetailRouteParams else {
      throw RouteFactoryError.ParameterError("Can not route to article detail. Wrong params provided.")
    }

    let viewModel = ArticleDetailViewModel(articleId: params.articleId)
    let controller = ArticleDetailController.create(viewModel: viewModel)

    return controller
  }
}
