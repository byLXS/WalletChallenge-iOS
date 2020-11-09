import Foundation
import WalletPresentationData
import CoreData

public class CardEntity: NSManagedObject, CDHelperEntity {
    
    public static var entityName: String! { return "CardEntity" }
    
    @NSManaged public var number: String
    @NSManaged public var kind: String
    @NSManaged public var texture: TextureEntity
    
    
    static public func save(data: [Card], completion: @escaping () -> ()) {
         CDHelper.backgroundContext?.perform({
            let entityList = data.convertEntityInPresentationData()
            CDHelper.synchronize()
         })
    }
}

extension CardEntity {
    
    public func convertEntityInPresentationData() -> Card {
        return Card(number: number, kind: kind, texture: texture.convertEntityInPresentationData())
    }
}

extension Array where Element == CardEntity {
    
    public func convertEntityInPresentationData() -> [Card] {
        var models: [Card] = []
        for item in self {
            models.append(item.convertEntityInPresentationData())
        }
        return models
    }
}

extension Card {
    
    public func convertResponseInEntity() -> CardEntity {
        let entity = CardEntity.newInBackgroundQueue()
        entity.kind = kind
        entity.number = number
        entity.texture = texture.convertResponseInEntity()
        return entity
    }
}

extension Array where Element == Card {
    
    public func convertEntityInPresentationData() -> [CardEntity] {
        var models: [CardEntity] = []
        for item in self {
            models.append(item.convertResponseInEntity())
        }
        return models
    }
}
