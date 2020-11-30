import Foundation
import WalletPresentationData
import UIKit
import WalletCore

class CardFolderItem {
    let card: Card
    var isSelected: Bool
    
    init(card: Card, isSelected: Bool) {
        self.card = card
        self.isSelected = isSelected
    }
}

protocol CardListInteractorProtocol {
    var folder: Folder { get }
    func numberOfItemsInSection(section: Int) -> Int
    func getItem(indexPath: IndexPath) -> CardFolderItem
    func getCard(indexPath: IndexPath) -> Card
    func setItemSelected(indexPath: IndexPath)
    func apply()
    func loadImage(indexPath: IndexPath, completion: @escaping (UIImage?) -> ())
}
class CardListInteractor: CardListInteractorProtocol {
    
    var items: [CardFolderItem]
    let folder: Folder
    
    init(cardList: [Card], folder: Folder) {
        self.folder = folder
        self.items = []
        let selectedIds = folder.cardNumbers
    
        for card in cardList {
            self.items.append(CardFolderItem(card: card, isSelected: false))
        }
        
        _  = self.items.filter({selectedIds.contains($0.card.number)}).map({$0.isSelected = true})
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        return items.count
    }
    
    func getItem(indexPath: IndexPath) -> CardFolderItem {
        return items[indexPath.row]
    }
    
    func getCard(indexPath: IndexPath) -> Card {
        return items[indexPath.row].card
    }
    
    func setItemSelected(indexPath: IndexPath) {
        self.items[indexPath.row].isSelected = !self.items[indexPath.row].isSelected
    }
    
    func apply() {
        let cardNumbers = self.items.filter({$0.isSelected == true}).map({$0.card.number})
        folder.cardNumbers = cardNumbers
    }
    
    func loadImage(indexPath: IndexPath, completion: @escaping (UIImage?) -> ()) {
        if let url = URL(string: items[indexPath.row].card.texture.front) {
            ImageLoader.shared.loadImage(from: url, completion: { (image) in
                DispatchQueue.main.async {
                    completion(image)
                }
            })
        }
    }
}
