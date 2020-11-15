import Foundation

public struct Card {
    public let number: String
    public let kind: String
    public let texture: Texture
    public let barcode: Barcode
    
    public init(number: String, kind: String, texture: Texture, barcode: Barcode) {
        self.number = number
        self.kind = kind
        self.texture = texture
        self.barcode = barcode
    }
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
