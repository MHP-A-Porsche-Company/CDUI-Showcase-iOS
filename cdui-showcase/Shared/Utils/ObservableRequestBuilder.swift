import RxSwift
import AwesomeCache

struct ObservableRequestBuilder {
  static func build<ResultType: Decodable>(url: String) -> Observable<ResultType> {
    return Observable.create({ observer in

      guard let convertedUrl = URL(string: url) else {
        Log.error("\(url): Invalid url", self)
        observer.onError(NetworkError.invalidUrl)
        return Disposables.create()
      }

      let urlRequest = URLRequest(url: convertedUrl)
      let urlSession = URLSession(configuration: URLSessionConfiguration.default)

      let task = urlSession.dataTask(with: urlRequest, completionHandler: { (data, _, error) in
        if let error = error {
          Log.error("\(url): \(error)", self)
          observer.onError(error)
          return
        }

        guard let data = data else {
          Log.error("\(url): Could not unwrap data response", self)
          observer.onError(NetworkError.unexpectedResponse)
          return
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970

        do {
          let parsedResult = try decoder.decode(ResultType.self, from: data)
          observer.onNext(parsedResult)
          observer.onCompleted()
        } catch let error {
          Log.error("\(url): \(error)", self)
          observer.onError(error)
        }
      })

      Log.task(task)
      task.resume()

      return Disposables.create {
        task.cancel()
      }
    })
  }
}
