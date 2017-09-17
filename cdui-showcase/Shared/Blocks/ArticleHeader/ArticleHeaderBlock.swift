import Foundation

struct ArticleHeaderBlock: Block {
  let id: String
  let title: String
  let subtitle: String
}

extension ArticleHeaderBlock: Diffable {
  var diffIdentifier: String {
    return id
  }

  func isEqual(to diffable: Diffable) -> Bool {
    guard let diffable = diffable as? ArticleHeaderBlock else {
      return false
    }

    return self == diffable
  }
}

extension ArticleHeaderBlock: Equatable {
  static func == (lhs: ArticleHeaderBlock, rhs: ArticleHeaderBlock) -> Bool {
    return lhs.id == rhs.id
      && lhs.title == rhs.title
      && lhs.subtitle == rhs.subtitle
  }
}
