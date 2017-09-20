import UIKit

struct StreamRouteFactory: RouteFactory {
  func params(from url: URL) -> RouteParams? {
    return nil
  }

  func build(with params: RouteParams?) throws -> UIViewController {
    let viewModel = StreamViewModel()
    let controller = StreamController.create(viewModel: viewModel)
    return controller
  }
}
