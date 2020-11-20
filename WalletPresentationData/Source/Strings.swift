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
    // MARK: CardDetail
    static public let grade = getText(value: "grade")
    static public let balance = getText(value: "balance")
    static public let value = getText(value: "value")
    static public let expireDate = getText(value: "expireDate")
    
    private static func getText(value: String) -> String {
        return NSLocalizedString(value, comment: "")
    }
}
