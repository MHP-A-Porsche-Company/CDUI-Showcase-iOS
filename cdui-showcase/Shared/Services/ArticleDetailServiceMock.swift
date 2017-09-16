import Foundation
import RxSwift
import RxCocoa

struct ArticleDetailServiceMock: ArticleDetailService {
  var space: Driver<ArticleDetailSpace> {
    if let space = mockSpace {
      return Driver.just(space)
    }

    return Driver.empty()
  }

  private let mockSpace: ArticleDetailSpace?

  init() {
    if let path = Bundle.main.path(forResource: "ArticleDetail", ofType: "json") {
      do {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970

        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
        let space = try decoder.decode(ArticleDetailSpace.self, from: data)

        mockSpace = space
      } catch let error {
        print(error)
        mockSpace = nil
      }
    } else {
      mockSpace = nil
    }
  }
}
