import Foundation

struct ArticleStreamBlock: Block {
  let id: String
  let user: User
  let imageUrl: URL?
  let title: String
  let subtitle: String
  let created: Date
}

extension ArticleStreamBlock: Diffable {
  var diffIdentifier: String {
    return id
  }

  func isEqual(to diffable: Diffable) -> Bool {
    guard let diffable = diffable as? ArticleStreamBlock else {
      return false
    }

    return self == diffable
  }
}

extension ArticleStreamBlock: Equatable {
  static func == (lhs: ArticleStreamBlock, rhs: ArticleStreamBlock) -> Bool {
    return lhs.id == rhs.id
      && lhs.user == rhs.user
      && lhs.imageUrl == rhs.imageUrl
      && lhs.title == rhs.title
      && lhs.subtitle == rhs.subtitle
      && lhs.created == rhs.created
  }
}
