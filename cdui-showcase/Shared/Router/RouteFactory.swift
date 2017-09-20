import UIKit

enum RouteFactoryError: Error {
  case QueryParameterError(String)
  case ParameterError(String)
}

protocol RouteParams {
}

protocol RouteFactory {
  func params(from url: URL) throws -> RouteParams?
  func build(with params: RouteParams?) throws -> UIViewController
}
