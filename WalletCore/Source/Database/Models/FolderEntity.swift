import Foundation
import WalletPresentationData
import CoreData

public class FolderEntity: NSManagedObject, CDHelperEntity {
    
    public static var entityName: String! { return "FolderEntity" }
    
    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var cardNumbers: [String]
    
    static public func save(data: [Card], completion: @escaping () -> ()) {
         CDHelper.backgroundContext?.perform({
            _ = data.convertPresentationDataInEntity()
            CDHelper.synchronize()
         })
    }
}

extension Array where Element == FolderEntity {
    
    public func convertEntityInPresentationData() -> [Folder] {
        var models: [Folder] = []
        for item in self {
            models.append(item.convertEntityInPresentationData())
        }
        return models
    }
}

extension FolderEntity {
    public func convertEntityInPresentationData() -> Folder {
        return Folder(id: id, name: name, cardNumbers: cardNumbers)
    }
}

extension Folder {
    
    public func convertPresentationDataInEntity() -> FolderEntity {
        let entity = FolderEntity.newInBackgroundQueue()
        entity.id = id
        entity.name = name
        entity.cardNumbers = cardNumbers
        return entity
    }
}

extension Array where Element == Folder {
    
    public func convertPresentationDataInEntity() -> [FolderEntity] {
        var models: [FolderEntity] = []
        for item in self {
            models.append(item.convertPresentationDataInEntity())
        }
        return models
    }
}
