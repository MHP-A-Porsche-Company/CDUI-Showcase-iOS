import UIKit

enum RouterTarget {
  case navigation
  case modal
}

protocol Router {
  var routeFactories: [Route: RouteFactory] { get set }

  func navigate(toUrl url: URL)
  func navigate(toRoute route: Route, params: RouteParams?, target: RouterTarget)

  func back(from target: RouterTarget)
}

struct RouterDefault: Router {
  var routeFactories = [Route: RouteFactory]()

  weak var navigationController: UINavigationController?

  func navigate(toUrl url: URL) {
    for (route, factory) in routeFactories where route.rawValue == url.path {
      guard let params = try? factory.params(from: url) else {
        return
      }

      navigate(toRoute: route, params: params, target: .navigation)
      return
    }

    UIApplication.shared.open(url, options: [:], completionHandler: nil)
  }

  func navigate(toRoute route: Route, params: RouteParams?, target: RouterTarget) {
    guard let factory = routeFactories[route] else {
      return
    }

    guard let viewController = try? factory.build(with: params) else {
      return
    }

    if let navigationController = navigationController, target == .navigation {
      navigationController.pushViewController(viewController, animated: true)
    } else if let navigationController = navigationController, target == .modal {
      var presentingController: UIViewController = navigationController

      while let modalChild = presentingController.presentedViewController {
        presentingController = modalChild
      }

      presentingController.present(viewController, animated: true, completion: nil)
    }
  }

  func back(from target: RouterTarget) {
    switch target {
    case .navigation:
      if let navigationController = navigationController {
        navigationController.popViewController(animated: true)
      }
    case .modal:
      if let navigationController = navigationController {
        navigationController.dismiss(animated: true, completion: nil)
      }
    }
  }
}
