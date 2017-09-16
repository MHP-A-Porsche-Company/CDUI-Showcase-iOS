import Foundation

struct UserBlock: Block {
  let id: String
  let user: User
}

extension UserBlock: Diffable {
  var diffIdentifier: String {
    return id
  }

  func isEqual(to diffable: Diffable) -> Bool {
    guard let diffable = diffable as? UserBlock else {
      return false
    }

    return self == diffable
  }
}

extension UserBlock: Equatable {
  static func == (lhs: UserBlock, rhs: UserBlock) -> Bool {
    return lhs.id == rhs.id
      && lhs.user == rhs.user
  }
}
