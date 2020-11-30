import Foundation
import WalletPresentationData
import WalletCore

enum FoldersDisplayItem {
    case folders
    case addFolder
}

protocol FoldersInteractorProtocol {
    var accountWorker: AccountWorker { get }
    func numberOfSections() -> Int
    func numberOfItemsInSection(section: Int) -> Int
    func getDisplayIten(section: Int) -> FoldersDisplayItem
    func getFolder(indexPath: IndexPath) -> Folder
    func addFolder(name: String)
    func removeFolder(indexPath: IndexPath)
}

class FoldersInteractor: FoldersInteractorProtocol {
    
    var presenter: FoldersPresenterProtocol?
    
    var accountWorker: AccountWorker
    var folderList: [Folder] {
        didSet {
            self.accountWorker.account.folders = folderList
        }
    }
    
    var displayItems: [FoldersDisplayItem] = [.folders, .addFolder]
    
    init(accountWorker: AccountWorker) {
        self.accountWorker = accountWorker
        self.folderList = accountWorker.account.folders
    }
    
    func numberOfSections() -> Int {
        return displayItems.count
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        switch displayItems[section] {
        case .folders:
            return folderList.count
        case .addFolder:
            return 1
        }
    }
    
    func getDisplayIten(section: Int) -> FoldersDisplayItem {
        return displayItems[section]
    }
    
    func getFolder(indexPath: IndexPath) -> Folder {
        return folderList[indexPath.row]
    }
    
    func addFolder(name: String) {
        let id = NSUUID().uuidString
        let newFolder = Folder(id: id, name: name, cardNumbers: [])
        self.folderList.append(newFolder)
        self.accountWorker.account.folders = folderList
        FolderEntity.asynchronouslyFindAll() { [weak self] (entityList) in
            _ = entityList.map({$0.destroyInBackgroundQueue()})
            let _ = self?.folderList.convertPresentationDataInEntity()
            CDHelper.synchronize()
        }
        
    }
    
    
    func removeFolder(indexPath: IndexPath) {
        FolderEntity.asynchronouslyFind("id=\"\(folderList[indexPath.row].id)\"") { (entityList) in
            _ = entityList.map({$0.destroyInBackgroundQueue()})
            CDHelper.synchronize()
        }
        self.folderList.remove(at: indexPath.row) 
    }
}

