import UIKit
import RxSwift

final class RemoteImageViewModel {
  let loadedImage: Variable<UIImage?> = Variable(nil)
  let loading: Variable<Bool> = Variable(false)

  private let imageUrl: String

  private let imageService: ImageService

  private var disposeBag = DisposeBag()

  init(imageUrl: String,
       imageServiceFactory: ImageServiceFactory = Services.defaultImageServiceFactory()) {
    self.imageService = imageServiceFactory()
    self.imageUrl = imageUrl
  }

  func load() {
    self.disposeBag = DisposeBag()

    loading.value = true
    imageService.get(imageUrl: imageUrl)
      .subscribe(
        onNext: { [weak self] image in
          self?.loadedImage.value = image
        },
        onError: { [weak self] _ in
          self?.loading.value = false
        },
        onCompleted: { [weak self] in
          self?.loading.value = false
        }
      )
      .addDisposableTo(disposeBag)
  }
}
