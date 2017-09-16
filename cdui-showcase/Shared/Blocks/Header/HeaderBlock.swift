import Foundation

struct HeaderBlock: Block {
  let id: String
  let title: String
  let subtitle: String
}

extension HeaderBlock: Diffable {
  var diffIdentifier: String {
    return id
  }

  func isEqual(to diffable: Diffable) -> Bool {
    guard let diffable = diffable as? HeaderBlock else {
      return false
    }

    return self == diffable
  }
}

extension HeaderBlock: Equatable {
  static func == (lhs: HeaderBlock, rhs: HeaderBlock) -> Bool {
    return lhs.id == rhs.id
      && lhs.title == rhs.title
      && lhs.subtitle == rhs.subtitle
  }
}
