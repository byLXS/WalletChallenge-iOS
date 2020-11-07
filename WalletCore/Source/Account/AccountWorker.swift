import Foundation
import WalletPresentationData
import WalletApi

public class AccountWorker {
    
    public let account: Account
    public let api = Api(logs: true)
    
    public init(account: Account) {
        self.account = account
    }
    
    public func fetchCardList(completionSuccess: @escaping ([Card]) -> (), completionFailure: @escaping (ErrorMessage) -> ()) {
        api.getCards() { (result: CompletionApiArray<CardResponse>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    let cardList = data.convertEntityInPresentationData()
                    self.account.cardList = cardList
                    completionSuccess(cardList)
                case .failure(let errorType):
                    completionFailure(.alert)
                }
            }
            
        }
    }
}
