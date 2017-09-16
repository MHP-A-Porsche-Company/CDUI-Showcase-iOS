import Foundation

extension DateFormatter {
  //Initializing date formatters is costly, so they will be held by shared instance for global access
  static let sharedInstance = DateFormatter()
  static let componentsInstance = DateComponentsFormatter()

  static func string(from date: Date, template: String) -> String {
    DateFormatter.sharedInstance.dateFormat = DateFormatter.dateFormat(fromTemplate: template, options: 0, locale: NSLocale.current)
    return DateFormatter.sharedInstance.string(from: date)
  }

  static func string(from date: Date, dateStyle: DateFormatter.Style) -> String {
    DateFormatter.sharedInstance.dateFormat = nil
    DateFormatter.sharedInstance.dateStyle = dateStyle
    DateFormatter.sharedInstance.timeStyle = .none
    return DateFormatter.sharedInstance.string(from: date)
  }

  static func string(from date: Date, timeStyle: DateFormatter.Style) -> String {
    DateFormatter.sharedInstance.dateFormat = nil
    DateFormatter.sharedInstance.dateStyle = .none
    DateFormatter.sharedInstance.timeStyle = timeStyle
    return DateFormatter.sharedInstance.string(from: date)
  }

  static func string(from date: Date, dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
    DateFormatter.sharedInstance.dateFormat = nil
    DateFormatter.sharedInstance.dateStyle = dateStyle
    DateFormatter.sharedInstance.timeStyle = timeStyle
    return DateFormatter.sharedInstance.string(from: date)
  }

  static func date(fromUtcString: String) -> Date? {
    DateFormatter.sharedInstance.dateFormat = "yyyy-MM-dd'T'HH:mmZ"
    return DateFormatter.sharedInstance.date(from: fromUtcString)
  }

  static func string(from timeInterval: TimeInterval, unitsStyle: DateComponentsFormatter.UnitsStyle = .abbreviated, allowedUnits: NSCalendar.Unit = [.hour, .minute], zeroFormattingBehavior: DateComponentsFormatter.ZeroFormattingBehavior = .dropAll) -> String? {
    DateFormatter.componentsInstance.allowedUnits = allowedUnits
    DateFormatter.componentsInstance.unitsStyle = unitsStyle
    DateFormatter.componentsInstance.zeroFormattingBehavior = zeroFormattingBehavior
    return DateFormatter.componentsInstance.string(from: timeInterval)
  }

  static func smartString(from timeInterval: TimeInterval, unitsStyle: DateComponentsFormatter.UnitsStyle = .abbreviated) -> String? {
    let allowedUnits: NSCalendar.Unit

    if abs(timeInterval) < 60*60 {
      allowedUnits = [.second]
    } else if abs(timeInterval) < 60*60 {
      allowedUnits = [.minute]
    } else if abs(timeInterval) < 60*60*24 {
      allowedUnits = [.hour]
    } else if abs(timeInterval) < 60*60*24*30 {
      allowedUnits = [.day]
    } else if abs(timeInterval) < 60*60*24*30*12 {
      allowedUnits = [.month]
    } else {
      allowedUnits = [.year]
    }

    DateFormatter.componentsInstance.allowedUnits = allowedUnits
    DateFormatter.componentsInstance.unitsStyle = unitsStyle
    DateFormatter.componentsInstance.zeroFormattingBehavior = .dropAll
    return DateFormatter.componentsInstance.string(from: timeInterval)
  }

  static func timeAgoString(from date: Date) -> String? {
    if let timeAgo = DateFormatter.smartString(from: Date().timeIntervalSinceReferenceDate - date.timeIntervalSinceReferenceDate) {
      return "vor \(timeAgo)"
    }

    return nil
  }
}
