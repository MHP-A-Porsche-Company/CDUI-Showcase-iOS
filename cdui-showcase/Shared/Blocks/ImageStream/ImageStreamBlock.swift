import Foundation

struct ImageStreamBlock: Block {
  let id: String
  let user: User
  let imageUrl: URL?
  let created: Date
}

extension ImageStreamBlock: Diffable {
  var diffIdentifier: String {
    return id
  }

  func isEqual(to diffable: Diffable) -> Bool {
    guard let diffable = diffable as? ImageStreamBlock else {
      return false
    }

    return self == diffable
  }
}

extension ImageStreamBlock: Equatable {
  static func == (lhs: ImageStreamBlock, rhs: ImageStreamBlock) -> Bool {
    return lhs.id == rhs.id
      && lhs.user == rhs.user
      && lhs.imageUrl == rhs.imageUrl
      && lhs.created == rhs.created
  }
}
