struct CarouselBlock: Block {
  let id: String
  let title: String?
  let items: [CarouselItem]
}

extension CarouselBlock: Diffable {
  var diffIdentifier: String {
    return id
  }

  func isEqual(to diffable: Diffable) -> Bool {
    guard let diffable = diffable as? CarouselBlock else {
      return false
    }

    return self == diffable
  }
}

extension CarouselBlock: Equatable {
  static func == (lhs: CarouselBlock, rhs: CarouselBlock) -> Bool {
    guard lhs.id == rhs.id && lhs.title == rhs.title else {
        return false
    }

    return compareBlockItems(lhs: lhs.items, rhs: rhs.items)
  }
}
