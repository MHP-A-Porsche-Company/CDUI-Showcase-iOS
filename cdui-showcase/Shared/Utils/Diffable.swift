// This whole thing is to wrap IGListKit ListDiffable into Diffable protocol
// to be able to use structs instead of classes for diffable objects
// Read more at: https://github.com/Instagram/IGListKit/issues/35#issuecomment-277503724

import IGListKit

/**
 A diffable value type that can be used in conjunction with
 `DiffUtility` to perform a diff between two result sets.
 */
public protocol Diffable {

  /**
   Returns a key that uniquely identifies the object.

   - returns: A key that can be used to uniquely identify the object.

   - note: Two objects may share the same identifier, but are not equal.

   - warning: This value should never be mutated.
   */
  var diffIdentifier: String { get }

  func isEqual(to diffable: Diffable) -> Bool
}

extension Diffable {
  var listDiffable: ListDiffable {
    return ListDiffableBox(value: self, identifier: self.diffIdentifier as NSObjectProtocol)
  }
}

/**
 Performs a diff operation between two sets of `ItemDiffable` results.
 */
public struct DiffUtility {

  public struct DiffResult {
    public typealias Move = (from: Int, to: Int)
    public let inserts: [Int]
    public let deletions: [Int]
    public let updates: [Int]
    public let moves: [Move]

    public let oldIndexForID: (_ id: String) -> Int
    public let newIndexForID: (_ id: String) -> Int
  }

  public static func diff<T: Diffable>(originalItems: [T], newItems: [T]) -> DiffResult {
    let old = originalItems.map({ $0.listDiffable })
    let new = newItems.map({ $0.listDiffable })
    let result = ListDiff(oldArray: old, newArray: new, option: .equality)

    let inserts = Array(result.inserts)
    let deletions = Array(result.deletes)
    let updates = Array(result.updates)

    let moves: [DiffResult.Move] = result.moves.map({ (from: $0.from, to: $0.to) })

    let oldIndexForID: (_ id: String) -> Int = { id in
      return result.oldIndex(forIdentifier: NSString(string: id))
    }
    let newIndexForID: (_ id: String) -> Int = { id in
      return result.newIndex(forIdentifier: NSString(string: id))
    }
    return DiffResult(inserts: inserts, deletions: deletions, updates: updates, moves: moves, oldIndexForID: oldIndexForID, newIndexForID: newIndexForID)
  }
}

final class ListDiffableBox<T: Diffable>: ListDiffable {

  let value: T
  let identifier: NSObjectProtocol

  init(value: T, identifier: NSObjectProtocol) {
    self.value = value
    self.identifier = identifier
  }

  // IGListDiffable

  func diffIdentifier() -> NSObjectProtocol {
    return identifier
  }

  func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    if let other = object as? ListDiffableBox<T> {
      return value.isEqual(to: other.value)
    }
    return false
  }
}
