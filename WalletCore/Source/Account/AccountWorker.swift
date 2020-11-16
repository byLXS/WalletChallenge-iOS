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
            guard !cardList.isEmpty else { return }
            cardList = cardList.sorted(by: {$0.number < $1.number})
            self.account.cardList = cardList
            DispatchQueue.main.async {
                completionSuccess(cardList)
            }
            
        }
        api.getCards() { (result: CompletionApiArray<CardResponse>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    let cardList = data.convertEntityInPresentationData().sorted(by: {$0.number < $1.number})
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
    }
}
