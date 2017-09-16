import Foundation

protocol Space: Codable {
  associatedtype HeaderType

  var id: String { get }
  var header: HeaderType { get }
  var blocks: [Block] { get }
}
