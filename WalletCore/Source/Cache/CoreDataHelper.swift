import Foundation
import CoreData
import UIKit

// MARK: - CoreDataHelper entity protocol
public protocol CDHelperEntity: class, NSFetchRequestResult {
    static var entityName: String! { get }
}

// MARK: - CoreDataHelper entity protocol extension
public extension CDHelperEntity {
    
    // MARK: Private static variables
    fileprivate static var mainContext: NSManagedObjectContext! {
        let context: NSManagedObjectContext! = CDHelper.mainContext
        
        assert((context != nil), "CDHelper error: mainContext must be set in the AppDelegate.")
        return context
    }
    
    fileprivate static var backgroundContext: NSManagedObjectContext! {
        let context: NSManagedObjectContext! = CDHelper.backgroundContext
        
        assert((context != nil), "CDHelper error: backgroundContext must be set in the AppDelegate.")
        return context
    }
    
    fileprivate static var persistentContainer: NSPersistentContainer! {
        let container: NSPersistentContainer! = CDHelper.persistentContainer
        
        assert((container != nil), "CDHelper error: persistentContainer must be set in the AppDelegate.")
        return container
    }
    
    
    // MARK: Public instance methods
    
    static func destroy(completion: @escaping () -> ()) {
        Self.asynchronouslyFindAll { (entityList) in
            guard !entityList.isEmpty else { return completion() }
            for entity in entityList {
                entity.destroyInBackgroundQueue()
            }
            completion()
        }
    }
    
    /// Delete the entity from the main context.
    func destroy() {
        if let object = self as? NSManagedObject {
            Self.mainContext.delete(object)
        }
    }
    
    /// Delete the entity from the background context.
    func destroyInBackgroundQueue() {
        Self.backgroundContext.performAndWait {
            do {
               if let object = self as? NSManagedObject {
                    Self.backgroundContext.delete(object)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: Public class methods
    
    /// Create a new empty entity.
    ///
    /// - returns:
    ///     A freshly created entity.
    static func new() -> Self {
        let entity = NSEntityDescription.entity(forEntityName: self.entityName, in: self.mainContext)!
        let object = NSManagedObject(entity: entity, insertInto: self.backgroundContext)
        self.backgroundContext.insert(object)
        return object as! Self
    }

    static func newInBackgroundQueue() -> Self {
        let newEntity: Self = NSEntityDescription.insertNewObject(forEntityName: self.entityName, into: backgroundContext) as! Self
        return newEntity
    }
    
    /// Create an entity using a data dictionary.
    ///
    /// - parameters:
    ///     - Dictionary: A dictionary of data used to fill your entity
    /// - returns:
    ///     A freshly created entity filled with the data.
    static func new(_ data: [String: Any?]) -> Self {
        let newEntity: NSManagedObject = self.new() as! NSManagedObject
        let availableKeys = newEntity.entity.attributesByName.keys
        
        for (key, value) in data {
            if !availableKeys.contains(key) {
                continue
            }
            
            newEntity.setValue(value, forKey: key)
        }
        
        return newEntity as! Self
    }
    
    static func findAll(usingSortDescriptors sortDescriptors: [NSSortDescriptor]! = nil) -> [Self] {
        return self._fetchUsingFetchRequest(self._buildFindAllRequest(usingSortDescriptors: sortDescriptors))
    }
    
    static func findOne(_ predicate: String) -> Self? {
        return self._fetchUsingFetchRequest(self._buildFindOneRequest(predicate)).first
    }
    
    static func find(_ predicate: String, usingSortDescriptors sortDescriptors: [NSSortDescriptor]! = nil, limit fetchLimit: Int! = nil) -> [Self] {
        return self._fetchUsingFetchRequest(self._buildFindRequest(predicate, usingSortDescriptors: sortDescriptors, limit: fetchLimit))
    }
    
    static func asynchronouslyFindAll(usingSortDescriptors sortDescriptors: [NSSortDescriptor]! = nil, completion: @escaping ([Self]) -> Void) {
        self._asynchronouslyFetchUsingRequest(self._buildFindAllRequest(usingSortDescriptors: sortDescriptors), completion: completion)
    }
    
    static func asynchronouslyFindOne(_ predicate: String, completion: @escaping (Self?) -> Void) {
        self._asynchronouslyFetchUsingRequest(self._buildFindOneRequest(predicate), completion: completion)
    }
    
    static func asynchronouslyFind(_ predicate: String, usingSortDescriptors sortDescriptors: [NSSortDescriptor]! = nil, limit fetchLimit: Int! = nil, completion: @escaping ([Self]) -> Void) {
        self._asynchronouslyFetchUsingRequest(self._buildFindRequest(predicate, usingSortDescriptors: sortDescriptors, limit: fetchLimit), completion: completion)
    }
    
    // MARK: Private class methods
    fileprivate static func _buildFetchRequestUsingPredicate(_ predicate: String!, sortDescriptors: [NSSortDescriptor]!, fetchLimit: Int!) -> NSFetchRequest<Self> {
        let fetchRequest: NSFetchRequest = NSFetchRequest<Self>()
        let entity: NSEntityDescription! = NSEntityDescription.entity(forEntityName: self.entityName, in: Self.backgroundContext)
        fetchRequest.entity = entity
        fetchRequest.predicate = (predicate != nil ? NSPredicate(format: predicate) : nil)
        fetchRequest.sortDescriptors = sortDescriptors
        if let fetchLimit = fetchLimit {
            fetchRequest.fetchLimit = fetchLimit
        }
        
        return fetchRequest
    }
    
    fileprivate static func _buildFindAllRequest(usingSortDescriptors sortDescriptors: [NSSortDescriptor]! = nil) -> NSFetchRequest<Self> {
        return self._buildFetchRequestUsingPredicate(nil, sortDescriptors: sortDescriptors, fetchLimit: nil)
    }
    
    fileprivate static func _buildFindOneRequest(_ predicate: String) -> NSFetchRequest<Self> {
        return self._buildFetchRequestUsingPredicate(predicate, sortDescriptors: nil, fetchLimit: nil)
    }
    
    fileprivate static func _buildFindRequest(_ predicate: String, usingSortDescriptors sortDescriptors: [NSSortDescriptor]! = nil, limit fetchLimit: Int! = nil) -> NSFetchRequest<Self> {
        return self._buildFetchRequestUsingPredicate(predicate, sortDescriptors: sortDescriptors, fetchLimit: fetchLimit)
    }
    
    fileprivate static func _fetchUsingFetchRequest(_ fetchRequest: NSFetchRequest<Self>) -> [Self] {
        guard let results = try? Self.mainContext.fetch(fetchRequest) else {
            print("CDHelper error: Cannot fetch results. Empty array has been returned.")
            return []
        }
        
        return results
    }
    
    fileprivate static func _fetchUsingFetchRequestInBackgroundQueue(_ fetchRequest: NSFetchRequest<Self>) -> [Self] {
        guard let results = try? Self.backgroundContext.fetch(fetchRequest) else {
            print("CDHelper error: Cannot fetch results. Empty array has been returned.")
            return []
        }
        
        return results
    }
    
    fileprivate static func _asynchronouslyFetchUsingRequest(_ fetchRequest: NSFetchRequest<Self>, completion: Any) {
        let asyncRequest: NSAsynchronousFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { (result: NSAsynchronousFetchResult!) -> Void in
            
            let result: [Self] = result.finalResult ?? []
            
            if let completion = completion as? (([Self]) -> Void) {
                completion(result)
            } else if let completion = completion as? ((Self?) -> Void) {
                completion(result.first ?? nil)
            } else {
                fatalError("CDHelper error: completion variable has a wrong type. Must be '([Self]) -> Void' or '(Self?) -> Void'.")
            }
        }
        
        do {
            try Self.backgroundContext.execute(asyncRequest as NSPersistentStoreRequest)
        } catch {
            print("CDHelper error: Cannot fetch results. Empty array has been returned.")
        }
    }
}

// MARK: - CoreDataHelper main class
public final class CDHelper {
    
    fileprivate static var _sharedInstance: CDHelper = CDHelper()
    
    // MARK: Public class variables
    public class var mainContext: NSManagedObjectContext! { return self._sharedInstance._mainContext }

    public class var backgroundContext: NSManagedObjectContext! { return self._sharedInstance._backgroundContext }
    
    public class var persistentContainer: NSPersistentContainer! { return self._sharedInstance._persistentContainer }
    
    // MARK: Private instance variables
    fileprivate var _mainContext: NSManagedObjectContext?
    
    fileprivate var _backgroundContext: NSManagedObjectContext?
    
    fileprivate var _persistentContainer: NSPersistentContainer?
    
    // MARK: Public class methods
    public class func initializeWithMainContext(persistentContainer: NSPersistentContainer) {
        self._sharedInstance._mainContext = persistentContainer.viewContext
        let backgroundContext = persistentContainer.newBackgroundContext()
        self._sharedInstance._backgroundContext = backgroundContext
        self._sharedInstance._persistentContainer = persistentContainer
        
    }
    
    
    public class func deleteAllData(_ entity: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try mainContext.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                mainContext.delete(objectData)
            }
        } catch let error {
            print("Detele all data in \(entity) error :", error)
        }
    }
    
    static public func synchronize() {
        do {
            try Self.backgroundContext.save()
            Self.mainContext.performAndWait {
                do {
                    try Self.mainContext.save()
                } catch {
                    print("Could not synchonize data. \(error), \(error.localizedDescription)")
                }
            }
        } catch {
            print("Could not synchonize data. \(error), \(error.localizedDescription)")
        }
    }
    
}

protocol NSManagedObjectHelper {
}
extension NSManagedObject: NSManagedObjectHelper {
}
extension NSManagedObjectHelper where Self: NSManagedObject {
    static func removeAllObjectsInContext(_ managedContext: NSManagedObjectContext) {
        let request: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: self))
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        do {
            deleteRequest.resultType = .resultTypeObjectIDs//to clear objects from memory
            let result = try managedContext.execute(deleteRequest) as? NSBatchDeleteResult
            if let objectIDArray = result?.result as? [NSManagedObjectID] {
                let changes = [NSDeletedObjectsKey : objectIDArray]
                /*By calling mergeChangesFromRemoteContextSave, all of the NSManagedObjectContext instances that are referenced will be notified that the list of entities referenced with the NSManagedObjectID array have been deleted and that the objects in memory are stale. This causes the referenced NSManagedObjectContext instances to remove any objects in memory that are loaded which match the NSManagedObjectID instances in the array.*/
                NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [managedContext])
            }
            try managedContext.save()
        } catch let error {
            print(error)
        }
    }
}

