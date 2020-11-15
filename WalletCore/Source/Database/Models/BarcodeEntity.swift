import Foundation
import CoreData
import WalletPresentationData

public class BarcodeEntity: NSManagedObject, CDHelperEntity {
    
    public static var entityName: String! { return "BarcodeEntity" }
    
    @NSManaged public var number: String
    @NSManaged public var kind: String
    
}

extension BarcodeEntity {
    public func convertEntityInPresentationData() -> Barcode {
        return Barcode(number: number, kind: kind)
    }
}

extension Barcode {
    
    public func convertResponseInEntity() -> BarcodeEntity {
        let entity = BarcodeEntity.newInBackgroundQueue()
        entity.number = number
        entity.kind = kind
        return entity
    }
}
