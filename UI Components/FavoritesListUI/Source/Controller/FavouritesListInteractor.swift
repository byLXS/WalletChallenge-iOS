import Foundation
import WalletPresentationData
import WalletCore
import UIKit

protocol FavouritesListInteractorProtocol {
    var cardFilter: CardFilter { get set }
    func numberOfItemsInSection(section: Int) -> Int
    func getCard(indexPath: IndexPath) -> Card
    func loadImage(indexPath: IndexPath, completion: @escaping (UIImage?) -> ())
}

class FavouritesListInteractor: FavouritesListInteractorProtocol {
    
    var cardFilter: CardFilter
    
    var cardList: [Card] = []
    
    init(cardList: [Card]) {
        self.cardList = cardList
        let categoryList: [CategoryItem] = [CategoryItem(type: .appliances), CategoryItem(type: .buildingMaterials), CategoryItem(type: .goods)]
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
}
