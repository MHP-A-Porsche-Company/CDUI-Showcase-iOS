enum BlockType: String, Codable {
  case articleStream
  case imageStream
  case eventStream

  case header
  case user
  case title
  case text
  case textHighlight
  case image
  case carousel
}
