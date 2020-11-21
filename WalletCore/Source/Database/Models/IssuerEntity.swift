import Foundation
import CoreData
import WalletPresentationData

public class IssuerEntity: NSManagedObject, CDHelperEntity {
    
    public static var entityName: String! { return "IssuerEntity" }
    
    @NSManaged public var name: String
    @NSManaged public var categories: [String]
    
//    func addCategoriesItems(value: [String]) {
//        self.mutableSetValue(forKey: "categories").add(value)
//    }
    
}

extension IssuerEntity {
    public func convertEntityInPresentationData() -> Issuer {
        return Issuer(name: name, categories: categories.map({(CategoryType(rawValue: $0) ?? .unknown)}))
    }
}

extension Issuer {
    
    public func convertResponseInEntity() -> IssuerEntity {
        let entity = IssuerEntity.newInBackgroundQueue()
        entity.name = name
        entity.categories = categories.map({$0.rawValue})
        return entity
    }
}

extension NSSet {
  public func toArray<T>() -> [T] {
    let array = self.map({ $0 as! T})
    return array
  }
}
