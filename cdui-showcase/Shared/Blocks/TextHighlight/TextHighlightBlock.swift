import Foundation

struct TextHighlightBlock: Block {
  let id: String
  let text: String
}

extension TextHighlightBlock: Diffable {
  var diffIdentifier: String {
    return id
  }

  func isEqual(to diffable: Diffable) -> Bool {
    guard let diffable = diffable as? TextHighlightBlock else {
      return false
    }

    return self == diffable
  }
}

extension TextHighlightBlock: Equatable {
  static func == (lhs: TextHighlightBlock, rhs: TextHighlightBlock) -> Bool {
    return lhs.id == rhs.id
      && lhs.text == rhs.text
  }
}
