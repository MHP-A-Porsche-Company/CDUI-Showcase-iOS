import Foundation

struct User: Codable {
  let id: String
  let name: String
  let position: String
  let imageUrl: URL?
}

extension User: Equatable {
  static func == (lhs: User, rhs: User) -> Bool {
    return lhs.id == rhs.id
      && lhs.name == rhs.name
      && lhs.position == rhs.position
      && lhs.imageUrl == rhs.imageUrl
  }
}
