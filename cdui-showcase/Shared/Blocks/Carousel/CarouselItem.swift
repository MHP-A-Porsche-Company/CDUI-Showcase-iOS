import Foundation

struct CarouselItem {
  let id: String
  let title: String
  let text: String
  let detailText: String
  let imageUrl: URL?
  let target: BlockTarget?
}

extension CarouselItem: Equatable {
  static func == (lhs: CarouselItem, rhs: CarouselItem) -> Bool {
    return lhs.id == rhs.id
      && lhs.text == rhs.text
      && lhs.title == rhs.title
      && lhs.detailText == rhs.detailText
      && lhs.imageUrl == rhs.imageUrl
  }
}
