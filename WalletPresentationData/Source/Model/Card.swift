import Foundation

public enum CardType: String {
    case loyalty
    case certificate
    case none
}

public protocol Card {
    var number: String { get }
    var kind: CardType { get }
    var texture: Texture { get }
    var barcode: Barcode { get }
}

public struct Texture {
    public let front: String
    public let back: String
    
    public init(front: String, back: String) {
        self.front = front
        self.back = back
    }
}

public struct Barcode {
    public let number: String
    public let kind: String
    
    public init(number: String, kind: String) {
        self.number = number
        self.kind = kind
    }
}


public struct LoyaltyCard: Card {
    public var number: String
    public var kind: CardType
    public var texture: Texture
    public var barcode: Barcode
    public var grade: String
    public var balance: Int
    
    public init(number: String, kind: CardType, texture: Texture, barcode: Barcode, grade: String, balance: Int) {
        self.number = number
        self.kind = kind
        self.texture = texture
        self.barcode = barcode
        self.grade = grade
        self.balance = balance
    }
    
}

public struct CertificateCard: Card {
    public var number: String
    public var kind: CardType
    public var texture: Texture
    public var barcode: Barcode
    public var value: Int
    public var expireDate: String
    
    public init(number: String, kind: CardType, texture: Texture, barcode: Barcode, value: Int, expireDate: String) {
        self.number = number
        self.kind = kind
        self.texture = texture
        self.barcode = barcode
        self.value = value
        self.expireDate = expireDate
    }
    
}

public struct DefaultCard: Card {
    public var number: String
    public var kind: CardType
    public var texture: Texture
    public var barcode: Barcode
    
    public init(number: String, kind: CardType, texture: Texture, barcode: Barcode) {
        self.number = number
        self.kind = kind
        self.texture = texture
        self.barcode = barcode
    }
    
}
