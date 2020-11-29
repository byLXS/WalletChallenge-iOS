import Foundation

public struct Strings {
    // MARK: Common
    static public let noInternetConnection = getText(value: "noInternetConnection")
    static public let add = getText(value: "add")
    static public let all = getText(value: "all")
    static public let clear = getText(value: "clear")
    static public let done = getText(value: "done")
    static public let internetIsNotAvailable = getText(value: "internetIsNotAvailable")
    static public let checkTheConnection = getText(value: "checkTheConnection")
    static public let internetIsConnected = getText(value: "internetIsConnected")
    static public let dataUpdated = getText(value: "dataUpdated")
    // MARK: Main
    static public let main = getText(value: "main")
    static public let myCard = getText(value: "myCard")
    static public let filter = getText(value: "filter")
    // MARK: CardFilter
    static public let apply = getText(value: "apply")
    static public let loyalty = getText(value: "loyalty")
    static public let certificate = getText(value: "certificate")
    static public let appliances = getText(value: "appliances")
    static public let buildingMaterials = getText(value: "buildingMaterials")
    static public let goods = getText(value: "goods")
    static public let mostUsed = getText(value: "mostUsed")
    // MARK: CardDetail
    static public let grade = getText(value: "grade")
    static public let balance = getText(value: "balance")
    static public let value = getText(value: "value")
    static public let expireDate = getText(value: "expireDate")
    static public let addToFavourites = getText(value: "addToFavourites")
    static public let removeFromFavourites = getText(value: "removeFromFavourites")
    static public let addedToFavourites = getText(value: "addedToFavourites")
    // MARK: Settings
    static public let settings = getText(value: "settings")
    static public let statistics = getText(value: "statistics")
    static public let language = getText(value: "language")
    static public let decoration = getText(value: "decoration")
    static public let favourites = getText(value: "favourites")
    // MARK: Decoration
    static public let choiceTheme = getText(value: "choiceTheme")
    static public let system = getText(value: "system")
    static public let light = getText(value: "light")
    static public let dark = getText(value: "dark")
    
    private static func getText(value: String) -> String {
        return NSLocalizedString(value, comment: "")
    }
}
