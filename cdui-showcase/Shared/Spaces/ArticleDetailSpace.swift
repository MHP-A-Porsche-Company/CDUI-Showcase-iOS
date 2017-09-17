import Foundation

struct ArticleDetailSpace: Space {
  let id: String
  let header: ArticleDetailSpace.Header
  let blocks: [Block]
}

extension ArticleDetailSpace {
  struct Header: Codable {
    let imageUrl: String?
  }
}

extension ArticleDetailSpace {
  private enum CodingKeys: CodingKey {
    case id
    case header
    case blocks
  }

  func encode(to encoder: Encoder) throws {
    //    var container = encoder.container(keyedBy: CodingKeys.self)
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    id = try container.decode(String.self, forKey: .id)
    header = try container.decode(ArticleDetailSpace.Header.self, forKey: .header)
    blocks = try BlockDecoder.decodeBlockArray(container: container, key: .blocks)
  }
}
