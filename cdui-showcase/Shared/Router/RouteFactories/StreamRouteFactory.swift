import UIKit

struct StreamRouteFactory: RouteFactory {
  func params(from: URL) -> RouteParams? {
    return nil
  }

  func build(params: RouteParams?) throws -> UIViewController {
    let viewModel = StreamViewModel()
    let controller = StreamController.create(viewModel: viewModel)
    return controller
  }
}
