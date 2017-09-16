import Foundation

struct TextBlock: Block {
  let id: String
  let text: String
}

extension TextBlock: Diffable {
  var diffIdentifier: String {
    return id
  }

  func isEqual(to diffable: Diffable) -> Bool {
    guard let diffable = diffable as? TextBlock else {
      return false
    }

    return self == diffable
  }
}

extension TextBlock: Equatable {
  static func == (lhs: TextBlock, rhs: TextBlock) -> Bool {
    return lhs.id == rhs.id
      && lhs.text == rhs.text
  }
}
