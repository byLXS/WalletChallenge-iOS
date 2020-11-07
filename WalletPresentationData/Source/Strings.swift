import Foundation

public struct Strings {
    // MARK: Common
    static public let noInternetConnection = getText(value: "noInternetConnection")
    // MARK: Main
    static public let main = getText(value: "main")
    
    private static func getText(value: String) -> String {
        return NSLocalizedString(value, comment: "")
    }
}
