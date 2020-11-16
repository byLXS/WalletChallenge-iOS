import Foundation
import CoreData
import WalletPresentationData

public class LoyaltyCardEntity: NSManagedObject, CDHelperEntity {
    
    public static var entityName: String! { return "LoyaltyCardEntity" }
    
    @NSManaged public var grade: String
    @NSManaged public var balance: NSNumber
    
}
