import Foundation
import WalletCore
import WalletPresentationData
import UIKit


protocol FolderItemInteractorProtocol {
    var accountWorker: AccountWorker { get }
    func numberOfSections() -> Int
    func numberOfItemsInSection(section: Int) -> Int
    func loadImage(indexPath: IndexPath, completion: @escaping (UIImage?) -> ())
    func getDisplayIten(section: Int) -> FoldersDisplayItem
    func getFolder() -> Folder
    func folderUpdated()
    func removeCardNumber(indexPath: IndexPath)
    func getCard(indexPath: IndexPath) -> Card
}

class FolderItemInteractor: FolderItemInteractorProtocol {
    
    let accountWorker: AccountWorker
    let folder: Folder
    var cardList: [Card] = []
    var displayItems: [FoldersDisplayItem] = [.folders, .addFolder]
    
    init(accountWorker: AccountWorker, folder: Folder) {
        self.accountWorker = accountWorker
        
        self.cardList =  accountWorker.account.cardList.filter({folder.cardNumbers.contains($0.number)})
        self.folder = folder
    }
    
    func getFolder() -> Folder {
        return folder
    }
    
    func folderUpdated() {
        self.cardList = accountWorker.account.cardList.filter({folder.cardNumbers.contains($0.number)})
        
        FolderEntity.asynchronouslyFind("id=\"\(folder.id)\"") { [weak self] (entityList) in
            _ = entityList.map({$0.destroyInBackgroundQueue()})
            _ = self?.folder.convertPresentationDataInEntity()
            CDHelper.synchronize()
        }
    }
    
    func numberOfSections() -> Int {
        return displayItems.count
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        switch displayItems[section] {
        case .folders:
            return cardList.count
        case .addFolder:
            return 1
        }
    }
    
    func getCard(indexPath: IndexPath) -> Card {
        return cardList[indexPath.row]
    }
    
    func getDisplayIten(section: Int) -> FoldersDisplayItem {
        return displayItems[section]
    }
    
    func removeCardNumber(indexPath: IndexPath) {
        cardList.remove(at: indexPath.row)
        folder.cardNumbers = cardList.map({$0.number})
        FolderEntity.asynchronouslyFind("id=\"\(folder.id)\"") { [ weak self] (entityList) in
            _ = entityList.map({$0.destroyInBackgroundQueue()})
            _ = self?.folder.convertPresentationDataInEntity()
            CDHelper.synchronize()
        }
    }
    
    func loadImage(indexPath: IndexPath, completion: @escaping (UIImage?) -> ()) {
        if let url = URL(string: cardList[indexPath.row].texture.front) {
            ImageLoader.shared.loadImage(from: url, completion: { (image) in
                DispatchQueue.main.async {
                    completion(image)
                }
            })
        }
    }
}
