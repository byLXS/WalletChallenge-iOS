import Foundation
import WalletPresentationData

public class CardWorker {
    
    var cardList: [Card] = []
    
    public init(account: Account) {
        self.cardList = account.cardList
    }
}
