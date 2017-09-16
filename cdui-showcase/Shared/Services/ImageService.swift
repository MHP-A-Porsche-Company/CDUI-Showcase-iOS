import RxSwift
import UIKit

protocol ImageService {
  func get(imageUrl: String) -> Observable<UIImage>
}
