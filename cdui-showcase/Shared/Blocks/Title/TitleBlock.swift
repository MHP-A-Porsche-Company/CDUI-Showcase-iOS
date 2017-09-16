import Foundation

struct TitleBlock: Block {
  let id: String
  let text: String
}

extension TitleBlock: Diffable {
  var diffIdentifier: String {
    return id
  }

  func isEqual(to diffable: Diffable) -> Bool {
    guard let diffable = diffable as? TitleBlock else {
      return false
    }

    return self == diffable
  }
}

extension TitleBlock: Equatable {
  static func == (lhs: TitleBlock, rhs: TitleBlock) -> Bool {
    return lhs.id == rhs.id
      && lhs.text == rhs.text
  }
}
