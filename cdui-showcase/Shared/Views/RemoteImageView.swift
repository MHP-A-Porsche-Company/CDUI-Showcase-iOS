import UIKit
import RxSwift

class RemoteImageView: UIView {

  var imageUrl: String? {
    willSet {
      if imageUrl != newValue {
        if let newUrl = newValue {
          viewModel = RemoteImageViewModel(imageUrl: newUrl)
        } else {
          viewModel = nil
        }
      }
    }
  }

  private var viewModel: RemoteImageViewModel? {
    willSet {
      disposeBag = DisposeBag()
      self.imageView.image = nil
    }
    didSet {
      setupBindings()
      viewModel?.load()
    }
  }

  private var imageView = UIImageView()

  private var disposeBag = DisposeBag()

  convenience init() {
    self.init(frame: .zero)
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    imageView.frame = bounds
  }

  private func setup() {
    backgroundColor = Theme.Color.imageBackground
    clipsToBounds = true

    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.backgroundColor = Theme.Color.imageBackground
    addSubview(imageView)
  }

  private func setupBindings() {
    viewModel?.loadedImage.asDriver()
      .drive(
        onNext: { [weak self] image in
          self?.imageView.image = image
        }
      ).addDisposableTo(disposeBag)
  }
}
