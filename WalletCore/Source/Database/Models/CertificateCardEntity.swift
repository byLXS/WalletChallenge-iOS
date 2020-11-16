import Foundation
import CoreData
import WalletPresentationData

public class CertificateCardEntity: NSManagedObject, CDHelperEntity {
    
    public static var entityName: String! { return "CertificateCardEntity" }
    
    @NSManaged public var value: NSNumber
    @NSManaged public var expireDate: String
    
}
