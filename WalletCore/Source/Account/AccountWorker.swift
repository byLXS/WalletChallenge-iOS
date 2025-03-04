import Foundation
import WalletPresentationData
import WalletApi

public class AccountWorker {
    
    public let account: Account
    public let api = Api(logs: true)
    public let storage = CoreDataManager()
    
    public init(account: Account) {
        self.account = account
    }
    
    public func fetchCardList(completionSuccess: @escaping ([Card]) -> (), completionFailure: @escaping (ErrorMessage) -> ()) {
        CardEntity.asynchronouslyFindAll() { (entityList) in
            var cardList = entityList.convertEntityInPresentationData()
            guard !cardList.isEmpty else {
                DispatchQueue.main.async {
                    completionSuccess([])
                }
                return
            }
            cardList = cardList.sorted(by: {$0.number < $1.number})
            self.account.cardList = cardList
            DispatchQueue.main.async {
                completionSuccess(cardList)
            }
            
        }
        api.getCards() { (result: CompletionApiArray<CardResponse>) in
            switch result {
            case .success(let data):
                var cardList = data.convertResponseInPresentationData().sorted(by: {$0.number < $1.number})
                let oldItems = self.account.cardList.filter({$0.isFavourites == true})
                let oldItemsViewsCount = self.account.cardList.filter({$0.viewsCount > 0})
                for oldItem in oldItems {
                    if let index = cardList.firstIndex(where: {$0.number == oldItem.number}) {
                        cardList[index].isFavourites = true
                    }
                }
                for oldItem in oldItemsViewsCount {
                    if let index = cardList.firstIndex(where: {$0.number == oldItem.number}) {
                        cardList[index].viewsCount = oldItem.viewsCount
                    }
                }
                self.account.cardList = cardList
                
                
                CardEntity.destroy() {
                    CardEntity.save(data: self.account.cardList) {
                    }
                }
                DispatchQueue.main.async {
                    completionSuccess(cardList)
                }
            case .failure( _):
                DispatchQueue.main.async {
                    completionFailure(.alert)
                }
            }
        }
    }
    
    public func fetchFolders(completionSuccess: @escaping ([Folder]) -> (), completionFailure: @escaping (ErrorMessage) -> ()) {
        FolderEntity.asynchronouslyFindAll() { (entityList) in
            let folders = entityList.convertEntityInPresentationData()
            guard !folders.isEmpty else {
                DispatchQueue.main.async {
                    completionSuccess([])
                }
                return
            }
            self.account.folders = folders
            DispatchQueue.main.async {
                completionSuccess(folders)
            }
            
        }
    }
}
