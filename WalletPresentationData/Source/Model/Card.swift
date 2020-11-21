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
    var issuer: Issuer { get }
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

public struct Issuer {
    public let name: String
    public let categories: [CategoryType]
    
    public init(name: String, categories: [CategoryType]) {
        self.name = name
        self.categories = categories
    }
}


public enum CategoryType: String {
    case appliances = "appliances"
    case buildingMaterials = "buildingMaterials"
    case goods = "goods"
    case unknown
    
    public var title: String {
        switch self {
        case .appliances: return Strings.appliances
        case .buildingMaterials: return Strings.buildingMaterials
        case .goods: return Strings.goods
        case .unknown: return ""
        }
    }
}

public struct LoyaltyCard: Card {
    public var number: String
    public var kind: CardType
    public var texture: Texture
    public var barcode: Barcode
    public var issuer: Issuer
    public var grade: String
    public var balance: Int
    
    public init(number: String, kind: CardType, texture: Texture, barcode: Barcode, issuer: Issuer, grade: String, balance: Int) {
        self.number = number
        self.kind = kind
        self.texture = texture
        self.barcode = barcode
        self.issuer = issuer
        self.grade = grade
        self.balance = balance
    }
    
}

public struct CertificateCard: Card {
    public var number: String
    public var kind: CardType
    public var texture: Texture
    public var barcode: Barcode
    public var issuer: Issuer
    public var value: Int
    public var expireDate: String
    
    public init(number: String, kind: CardType, texture: Texture, barcode: Barcode, issuer: Issuer, value: Int, expireDate: String) {
        self.number = number
        self.kind = kind
        self.texture = texture
        self.barcode = barcode
        self.issuer = issuer
        self.value = value
        self.expireDate = expireDate
    }
    
}

public struct DefaultCard: Card {
    public var number: String
    public var kind: CardType
    public var texture: Texture
    public var barcode: Barcode
    public var issuer: Issuer
    
    public init(number: String, kind: CardType, texture: Texture, barcode: Barcode, issuer: Issuer) {
        self.number = number
        self.kind = kind
        self.texture = texture
        self.barcode = barcode
        self.issuer = issuer
    }
    
}
