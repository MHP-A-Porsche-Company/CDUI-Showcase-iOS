import Foundation

final class BlockDecoder {
  private struct MetaInfo: Codable {
    let type: BlockType
  }

  static func decodeArray<Key>(container: KeyedDecodingContainer<Key>, key: KeyedDecodingContainer<Key>.Key) throws -> [Block] {

    var blockDecoder = try container.nestedUnkeyedContainer(forKey: key)
    let blockMetaInfos = try container.decode([MetaInfo].self, forKey: key)

    var decodedBlocks: [Block] = []

    for meta in blockMetaInfos {
      switch meta.type {
      case .articleStream:
        break
      case .imageStream:
        break
      case .eventStream:
        break
      case .header:
        break
      case .user:
        break
      case .title:
        break
      case .text:
        break
      case .textHighlight:
        break
      case .image:
        break
      case .carousel:
        break
      }
    }

    return decodedBlocks
  }
}
