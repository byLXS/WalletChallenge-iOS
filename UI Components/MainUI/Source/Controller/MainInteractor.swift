import Foundation
import WalletPresentationData
import UIKit.UIImage
import WalletCore

protocol MainInteractorProtocol {
    func fetchCardList()
    func numberOfItemsInSection(section: Int) -> Int
    func getCard(indexPath: IndexPath) -> Card
    func loadImage(indexPath: IndexPath, completion: @escaping (UIImage?) -> ())
}

class MainInteractor: MainInteractorProtocol {
    
    var presenter: MainPresenterProtocol?
    
    let accountWorker: AccountWorker
    
    var cardList: [Card] {
        return accountWorker.account.cardList
    }
    
    init(accountWorker: AccountWorker) {
        self.accountWorker = accountWorker
    }
    
    func fetchCardList() {
        accountWorker.fetchCardList(completionSuccess: { (cards) in
            self.presenter?.reloadList()
        }) { (_) in
            
        }
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        return accountWorker.account.cardList.count
    }
    
    func getCard(indexPath: IndexPath) -> Card {
        return cardList[indexPath.row]
    }
    
    func loadImage(indexPath: IndexPath, completion: @escaping (UIImage?) -> ()) {
        if let url = URL(string: cardList[indexPath.row].texture.front) {
            ImageLoader.shared.loadImage(from: url, completion: { (image) in
                completion(image)
            })
        }
    }
}
