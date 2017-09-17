import UIKit

enum RouteFactoryError: Error {
  case ParameterError(String)
}

protocol RouteParams {
}

protocol RouteFactory {
  func params(from: URL) throws -> RouteParams?
  func build(params: RouteParams?) throws -> UIViewController
}
