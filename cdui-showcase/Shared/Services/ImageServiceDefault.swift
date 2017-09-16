import RxSwift
import UIKit
import AwesomeCache

struct ImageServiceDefault: ImageService {

  // Cache Images for one month
  private static let cacheExpiry = AwesomeCache.CacheExpiry.seconds(30*60*60*24*4)
  private static var cache: Cache<UIImage>? {
    do {
      return try Cache<UIImage>(name: "cdui.images")
    } catch {
      return nil
    }
  }

  static func cleanCache() {
    ImageServiceDefault.cache?.removeAllObjects()
  }

  func get(imageUrl: String) -> Observable<UIImage> {
    return Observable.create { observer in

      let cache = ImageServiceDefault.cache
      let cacheKey = imageUrl

      // Retrieve cached image
      if let image = cache?[cacheKey] {
        observer.onNext(image)
        observer.onCompleted()
        return Disposables.create()
      }

      // If no image cached, download it
      guard let convertedUrl = URL(string: imageUrl) else {
        observer.onError(NetworkError.invalidUrl)
        return Disposables.create()
      }

      let urlSession = URLSession(configuration: URLSessionConfiguration.default)
      let urlRequest = URLRequest(url: convertedUrl)

      let task = urlSession.downloadTask(with: urlRequest, completionHandler: { (url, _, error) in
        if let error = error {
          observer.onError(error)
          return
        }

        // Read url and return UIImage
        guard let url = url, let data = NSData(contentsOf: url), let image = UIImage(data: data as Data) else {
          observer.onError(NetworkError.unexpectedResponse)
          return
        }

        cache?.setObject(image, forKey: cacheKey, expires: ImageServiceDefault.cacheExpiry)
        observer.onNext(image)
        observer.onCompleted()
      })

      task.resume()

      return Disposables.create {
        task.cancel()
      }
    }
  }
}
