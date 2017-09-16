import Foundation

struct EventStreamBlock: Block {
  let id: String
  let title: String
  let subtitle: String
  let date: Date
}

extension EventStreamBlock: Diffable {
  var diffIdentifier: String {
    return id
  }

  func isEqual(to diffable: Diffable) -> Bool {
    guard let diffable = diffable as? EventStreamBlock else {
      return false
    }

    return self == diffable
  }
}

extension EventStreamBlock: Equatable {
  static func == (lhs: EventStreamBlock, rhs: EventStreamBlock) -> Bool {
    return lhs.id == rhs.id
      && lhs.title == rhs.title
      && lhs.subtitle == rhs.subtitle
      && lhs.date == rhs.date
  }
}
