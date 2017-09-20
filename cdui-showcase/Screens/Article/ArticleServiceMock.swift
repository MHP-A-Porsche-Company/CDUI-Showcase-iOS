import Foundation
import RxSwift
import RxCocoa

struct ArticleServiceMock: ArticleService {
  func getSpace(articleId: String) -> Observable<ArticleDetailSpace> {
    if let path = Bundle.main.path(forResource: "ArticleDetail", ofType: "json") {
      do {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970

        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
        let space = try decoder.decode(ArticleDetailSpace.self, from: data)

        return Observable.just(space)
      } catch let error {
        print(error)
        return Observable.empty()
      }
    } else {
      return Observable.empty()
    }
  }
}
