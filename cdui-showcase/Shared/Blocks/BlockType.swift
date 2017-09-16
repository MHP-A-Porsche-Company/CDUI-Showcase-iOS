enum BlockType: String, Codable {
  case articleStream = "ArticleStream"
  case imageStream = "ImageStream"
  case eventStream = "EventStream"

  case header = "header"
  case user = "user"
  case title = "title"
  case text = "text"
  case textHighlight = "textHighlight"
  case image = "image"
  case carousel = "carousel"
}
