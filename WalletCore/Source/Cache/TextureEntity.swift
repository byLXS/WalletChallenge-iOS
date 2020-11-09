import Foundation
import CoreData
import WalletPresentationData

public class TextureEntity: NSManagedObject, CDHelperEntity {
    
    public static var entityName: String! { return "TextureEntity" }
    
    @NSManaged public var front: String
    @NSManaged public var back: String
    
}

extension TextureEntity {
    public func convertEntityInPresentationData() -> Texture {
        return Texture(front: front, back: back)
    }
}

extension Texture {
    
    public func convertResponseInEntity() -> TextureEntity {
        let entity = TextureEntity.newInBackgroundQueue()
        entity.front = front
        entity.back = back
        return entity
    }
}
