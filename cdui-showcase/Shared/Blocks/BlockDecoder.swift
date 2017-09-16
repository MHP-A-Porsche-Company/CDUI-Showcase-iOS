import Foundation

final class BlockDecoder {
  private struct MetaInfo: Codable {
    let type: BlockType
  }

  static func decodeBlockArray<Key>(container: KeyedDecodingContainer<Key>, key: KeyedDecodingContainer<Key>.Key) throws -> [Block] {

    var blockDecoder = try container.nestedUnkeyedContainer(forKey: key)
    let blockMetaInfos = try container.decode([MetaInfo].self, forKey: key)

    var decodedBlocks: [Block] = []

    for meta in blockMetaInfos {
      switch meta.type {
      case .articleStream:
        decodedBlocks.append(try blockDecoder.decode(ArticleStreamBlock.self))
      case .imageStream:
        decodedBlocks.append(try blockDecoder.decode(ImageStreamBlock.self))
      case .eventStream:
        decodedBlocks.append(try blockDecoder.decode(EventStreamBlock.self))
      case .header:
        decodedBlocks.append(try blockDecoder.decode(HeaderBlock.self))
      case .user:
        decodedBlocks.append(try blockDecoder.decode(UserBlock.self))
      case .title:
        decodedBlocks.append(try blockDecoder.decode(TitleBlock.self))
      case .text:
        decodedBlocks.append(try blockDecoder.decode(TextBlock.self))
      case .textHighlight:
        decodedBlocks.append(try blockDecoder.decode(TextHighlightBlock.self))
      case .image:
        decodedBlocks.append(try blockDecoder.decode(ImageBlock.self))
      case .carousel:
        decodedBlocks.append(try blockDecoder.decode(CarouselBlock.self))
      }
    }

    return decodedBlocks
  }
}
