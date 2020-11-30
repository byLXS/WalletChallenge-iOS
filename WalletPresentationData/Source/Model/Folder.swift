import Foundation

public class Folder {
    public let id: String
    public let name: String
    public var cardNumbers: [String]
    
    public init(id: String, name: String, cardNumbers: [String]) {
        self.id = id
        self.name = name
        self.cardNumbers = cardNumbers
    }
}
