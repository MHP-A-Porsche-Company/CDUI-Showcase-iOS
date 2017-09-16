import Foundation
import RxSwift
import RxCocoa

struct StreamServiceMock: StreamService {
  var space: Driver<StreamSpace> {
    if let space = mockSpace {
      return Driver.just(space)
    }

    return Driver.empty()
  }

  private let mockSpace: StreamSpace?

  init() {
    if let path = Bundle.main.path(forResource: "Stream", ofType: "json") {
      do {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970

        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
        let space = try decoder.decode(StreamSpace.self, from: data)

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
