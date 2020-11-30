import Foundation
import WalletPresentationData
import UIKit.UIImage
import WalletCore

protocol MainInteractorProtocol {
    var accountWorker: AccountWorker { get }
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
        let categoryList: [CategoryItem] = CategoryItem.getDefaultItems()
        self.cardFilter = CardFilter(cardPresentationStyle: .medium, cardType: .all, selectedCategoryItems: categoryList, isSelected: false)
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
        if cardFilter.selectedCategoryItems.contains(where: {$0.isSelected == true}) {
            for selectedCategoryItem in cardFilter.selectedCategoryItems {
                if selectedCategoryItem.isSelected {
                    if selectedCategoryItem.type != .mostUsed {
                        let oldCardList = self.cardList
                        self.cardList = []
                        self.cardList.append(contentsOf: oldCardList.filter({$0.issuer.categories.contains(selectedCategoryItem.type)}))
                    }
                }
            }
        }
        let selectedCategoryItems = cardFilter.selectedCategoryItems.filter({$0.isSelected == true})
        if let _ = selectedCategoryItems.filter({$0.type == .mostUsed}).first {
            let oldCardList = self.cardList
            self.cardList = []
            self.cardList.append(contentsOf: oldCardList.sorted(by: {$0.viewsCount > $1.viewsCount}))
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
