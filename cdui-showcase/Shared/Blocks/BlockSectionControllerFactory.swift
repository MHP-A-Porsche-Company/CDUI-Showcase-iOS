import IGListKit

struct BlockSectionControllerFactory {
  static func sectionController(for object: Any) -> ListSectionController {
    switch object {
    case _ as ListDiffableBox<ArticleStreamBlock>:
      return ArticleStreamSectionController()

    case _ as ListDiffableBox<ImageStreamBlock>:
      return ImageStreamSectionController()

    case _ as ListDiffableBox<EventStreamBlock>:
      return EventStreamSectionController()

    case _ as ListDiffableBox<ArticleHeaderBlock>:
      return ArticleHeaderSectionController()

    case _ as ListDiffableBox<UserBlock>:
      return UserSectionController()

    case _ as ListDiffableBox<TitleBlock>:
      return TitleSectionController()

    case _ as ListDiffableBox<TextBlock>:
      return TextSectionController()

    case _ as ListDiffableBox<TextHighlightBlock>:
      return TextHighlightSectionController()

    case _ as ListDiffableBox<ImageBlock>:
      return ImageSectionController()

    case _ as ListDiffableBox<CarouselBlock>:
      return CarouselSectionController()

    default:
      print("Encountered block with unexpected type \(object) in \(type(of: self)).")
      return EmptySectionController()
    }
  }
}
