typealias BlockTarget = (() -> Void)

protocol Block: Codable, Diffable {
  var id: String { get }
}

extension Block {
  static func compareBlockItems<T: Equatable>(lhs: [T], rhs: [T]) -> Bool {
    var allItemsEqual = true

    if lhs.count == rhs.count {
      for (index, item) in lhs.enumerated() where item != rhs[index] {
        allItemsEqual = false
        break
      }
    } else {
      allItemsEqual = false
    }

    return allItemsEqual
  }
}
