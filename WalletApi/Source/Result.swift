import Foundation

public enum ErrorMessageType {
    case connectionError(message: String)
    case apiError(message: String?)
    case parsingError(message: String)
    
    
    public var message: String {
        switch self {
        case let .connectionError(message):
            return message
        case let .apiError(message):
            return message ?? ""
        case let .parsingError(message):
            return message
        }
    }
}

public enum Result<T> {
    case success(data: T)
    case failure(errorType: ErrorMessageType)
    
    var textError: String {
        switch self {
        case .success:
            return ""
        case .failure(let error):
            return error.message
        }
    }
    
    var errorMessageType: ErrorMessageType? {
        switch self {
        case .success:
            return nil
        case .failure(let errorType):
            return errorType
        }
    }
}
