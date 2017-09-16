import Foundation

struct ImageBlock: Block {
  let id: String
  let text: String
  let imageUrl: URL?
}

extension ImageBlock: Diffable {
  var diffIdentifier: String {
    return id
  }

  func isEqual(to diffable: Diffable) -> Bool {
    guard let diffable = diffable as? ImageBlock else {
      return false
    }

    return self == diffable
  }
}

extension ImageBlock: Equatable {
  static func == (lhs: ImageBlock, rhs: ImageBlock) -> Bool {
    return lhs.id == rhs.id
      && lhs.text == rhs.text
      && lhs.imageUrl == rhs.imageUrl
  }
}
