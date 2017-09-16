import Foundation

struct StreamSpace: Space {
  let id: String
  let header: StreamSpace.Header
  let blocks: [Block]
}

extension StreamSpace {
  struct Header: Codable {
    let title: String
  }
}

extension StreamSpace {
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
    header = try container.decode(StreamSpace.Header.self, forKey: .header)
    blocks = try BlockDecoder.decodeBlockArray(container: container, key: .blocks)
  }
}
