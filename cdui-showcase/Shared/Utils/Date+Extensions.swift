import Foundation
import UIKit

extension Date {
  var asEpoch: Double {
    return self.timeIntervalSince1970 * 1000
  }
}

extension Double {
  var asDate: Date {
    return Date(timeIntervalSince1970: self/1000 as TimeInterval)
  }
}
