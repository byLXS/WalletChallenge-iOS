import Foundation

public struct Card {
    public let number: String
    public let kind: String
    public let texture: Texture
    
    public init(number: String, kind: String, texture: Texture) {
        self.number = number
        self.kind = kind
        self.texture = texture
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
