import Foundation
import CoreData

public class CoreDataManager {
    
    var context = CDHelper.mainContext
    var backgroundContext = CDHelper.backgroundContext

    
    public init() {
        CDHelper.initializeWithMainContext(persistentContainer: persistentContainer)
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        var modelURL = Bundle(for: type(of: self)).url(forResource: "WalletDatabase", withExtension: "momd")!
        let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL)!
        
        let container = NSPersistentContainer(name: "WalletDatabase", managedObjectModel: managedObjectModel)
        container.persistentStoreDescriptions.first?.shouldInferMappingModelAutomatically = false
        container.loadPersistentStores { (storeDescription, error) in
            
            if let err = error{
                fatalError("❌ Loading of store failed:\(err)")
            }
        }
        
        return container
    }()
}
