import Foundation

public struct Strings {
    // MARK: Common
    static public let noInternetConnection = getText(value: "noInternetConnection")
    static public let add = getText(value: "add")
    static public let all = getText(value: "all")
    // MARK: Main
    static public let main = getText(value: "main")
    static public let myCard = getText(value: "myCard")
    static public let filter = getText(value: "filter")
    // MARK: CardFilter
    static public let apply = getText(value: "apply")
    static public let loyalty = getText(value: "loyalty")
    static public let certificate = getText(value: "certificate")
    
    private static func getText(value: String) -> String {
        return NSLocalizedString(value, comment: "")
    }
}
