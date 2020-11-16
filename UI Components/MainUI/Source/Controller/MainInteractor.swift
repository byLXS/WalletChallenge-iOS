import Foundation
import WalletPresentationData
import UIKit.UIImage
import WalletCore

protocol MainInteractorProtocol {
    var cardFilter: CardFilter { get set }
    func fetchCardList()
    func reloadItems()
    func numberOfItemsInSection(section: Int) -> Int
    func getCard(indexPath: IndexPath) -> Card
    func loadImage(indexPath: IndexPath, completion: @escaping (UIImage?) -> ())
}

class MainInteractor: MainInteractorProtocol {
    
    var presenter: MainPresenterProtocol?
    
    let accountWorker: AccountWorker
    
    var cardFilter: CardFilter
    
    var cardList: [Card] = []
    
    init(accountWorker: AccountWorker) {
        self.accountWorker = accountWorker
        self.cardFilter = CardFilter(cardPresentationStyle: .medium, cardType: .all)
    }
    
    func fetchCardList() {
        accountWorker.fetchCardList(completionSuccess: { (cards) in
            self.cardList = self.accountWorker.account.cardList
            self.presenter?.reloadList()
        }) { (_) in
            
        }
    }
    
    func reloadItems() {
        let allCardList = accountWorker.account.cardList
        switch cardFilter.cardType {
        case .all:
            self.cardList = allCardList
        case .certificate:
            self.cardList = allCardList.filter({$0.kind == .certificate})
        case .loyalty:
            self.cardList = allCardList.filter({$0.kind == .loyalty})
        }
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        return cardList.count
    }
    
    func getCard(indexPath: IndexPath) -> Card {
        return cardList[indexPath.row]
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
