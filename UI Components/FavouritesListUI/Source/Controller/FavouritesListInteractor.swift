import Foundation
import WalletPresentationData
import WalletCore
import UIKit

protocol FavouritesListInteractorProtocol {
    var cardFilter: CardFilter { get set }
    func numberOfItemsInSection(section: Int) -> Int
    func getCard(indexPath: IndexPath) -> Card
    func loadImage(indexPath: IndexPath, completion: @escaping (UIImage?) -> ())
    func cardChanged(card: Card)
}

class FavouritesListInteractor: FavouritesListInteractorProtocol {
    
    var presenter: FavouritesListPresenterProtocol?
    
    var cardFilter: CardFilter
    
    var cardList: [Card] = []
    
    init(cardList: [Card]) {
        self.cardList = cardList
        let categoryList: [CategoryItem] = CategoryItem.getDefaultItems()
        self.cardFilter = CardFilter(cardPresentationStyle: .medium, cardType: .all, selectedCategoryItems: categoryList, isSelected: false)
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
    
    func cardChanged(card: Card) {
        if card.isFavourites {
            cardList.append(card)
            presenter?.reloadList()
        } else {
            if let index = cardList.firstIndex(where: {$0.number == card.number}) {
                cardList.remove(at: index)
                presenter?.reloadList()
            }
        }
    }
}
