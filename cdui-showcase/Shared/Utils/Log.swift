import Foundation

struct Log {
  static var level: LogLevel = .info

  static func task(_ task: URLSessionTask, _ level: LogLevel = .info) {
    guard Log.shouldLog(level: level) else {
      return
    }

    let request = task.currentRequest ?? task.originalRequest
    if let request = request {
      var output = "======================"
      output += "\nTask:\n"

      if let url = request.url {
        output += "\(url)"
        output += "\n"
      }
      if let header = request.allHTTPHeaderFields {
        output += "\(header)"
        output += "\n"
      }

      if let body = request.httpBody {
        output += "\(NSString(data: body, encoding: String.Encoding.ascii.rawValue)!)"
        output += "\n"
      }

      output += "======================"
      print(output)
    }
  }

  static func verbose<T>(_ message: String, _ caller: T?) {
    Log.message(message, .verbose, caller)
  }

  static func debug<T>(_ message: String, _ caller: T?) {
    Log.message(message, .debug, caller)
  }

  static func info<T>(_ message: String, _ caller: T?) {
    Log.message(message, .info, caller)
  }

  static func warning<T>(_ message: String, _ caller: T?) {
    Log.message(message, .warning, caller)
  }

  static func error<T>(_ message: String, _ caller: T?) {
    Log.message(message, .error, caller)
  }

  static func message<T>(_ message: String, _ level: LogLevel = .info, _ caller: T?) {
    guard Log.shouldLog(level: level) else {
      return
    }

    if let caller = caller {
      print("[\(type(of: caller))] \(level.name) \(message)")
    } else {
      print(message)
    }
  }

  private static func shouldLog(level: LogLevel) -> Bool {
    switch Log.level {
    case .only(let currentKey):
      switch level {
      case .only(let levelKey):
        return levelKey == currentKey
      default:
        return false
      }
    case .error:
      return level == LogLevel.error
    case .warning:
      return level == LogLevel.error
        || level == LogLevel.warning
    case .info:
      return level == LogLevel.error
        || level == LogLevel.warning
        || level == LogLevel.info
    case .debug:
      return level == LogLevel.error
        || level == LogLevel.warning
        || level == LogLevel.info
        || level == LogLevel.debug
    case .verbose:
      return true
    }
  }
}

enum LogLevel {
  case verbose
  case debug
  case info
  case warning
  case error
  case only(String)
}

extension LogLevel {
  var name: String {
    switch self {
    case .verbose:
      return "😊 VERBOSE"
    case .debug:
      return "🤓 DEBUG"
    case .info:
      return "🤔 INFO"
    case .warning:
      return "😡 WARNING"
    case .error:
      return "💀 ERROR"
    case .only(let value):
      return "😎 ONLY(\(value))"
    }
  }
}

extension LogLevel: Equatable {
  static func == (lhs: LogLevel, rhs: LogLevel) -> Bool {
    switch lhs {
    case .only(let lhsValue):
      switch rhs {
      case .only(let rhsValue):
        return lhsValue == rhsValue
      default:
        return false
      }
    case .verbose:
      switch rhs {
      case .verbose:
        return true
      default:
        return false
      }
    case .debug:
      switch rhs {
      case .debug:
        return true
      default:
        return false
      }
    case .info:
      switch rhs {
      case .info:
        return true
      default:
        return false
      }
    case .warning:
      switch rhs {
      case .warning:
        return true
      default:
        return false
      }
    case .error:
      switch rhs {
      case .error:
        return true
      default:
        return false
      }
    }
  }
}
