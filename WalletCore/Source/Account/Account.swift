import Foundation
import WalletPresentationData

public enum AccountNetworkState: Equatable {
    case waitingForNetwork
    case connecting
    case updating
    case online
}


public class Account {
    public var networkState: AccountNetworkState = .waitingForNetwork
    public var cardList: [Card] = []
    public var folders: [Folder] = []
    public var id: Int
    
    public init(id: Int) {
        self.id = id
    }
}
