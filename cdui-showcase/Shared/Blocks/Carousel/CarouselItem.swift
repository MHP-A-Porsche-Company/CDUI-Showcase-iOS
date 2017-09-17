import Foundation

struct CarouselItem: Codable {
  let id: String
  let text: String?
  let imageUrl: String?
}

extension CarouselItem: Equatable {
  static func == (lhs: CarouselItem, rhs: CarouselItem) -> Bool {
    return lhs.id == rhs.id
      && lhs.text == rhs.text
      && lhs.imageUrl == rhs.imageUrl
  }
}
