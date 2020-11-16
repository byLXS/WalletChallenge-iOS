import Foundation
import WalletPresentationData

protocol CardFilterInteractorProtocol {
    var cardFilter: CardFilter { get set }
    var cardPresentationStyleItems: [CardPresentationStyle] { get }
    func numberOfItemsInSection(section: Int) -> Int
    func getStyle(indexPath: IndexPath) -> CardPresentationStyle
    func selectItem(index: Int)
    func scrollToSelectedStyleItem() 
}

class CardFilterInteractor: CardFilterInteractorProtocol {
    
    var presenter: CardFilterPresenterProtocol?
    
    let cardPresentationStyleItems: [CardPresentationStyle] = [.small, .medium]
    
    var cardFilter: CardFilter
    
    init(cardFilter: CardFilter) {
        self.cardFilter = cardFilter
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        return cardPresentationStyleItems.count
    }
    
    func getStyle(indexPath: IndexPath) -> CardPresentationStyle {
        return cardPresentationStyleItems[indexPath.row]
    }
    
    func selectItem(index: Int) {
        let item = cardPresentationStyleItems[index]
        cardFilter.cardPresentationStyle = item
    }
    
    func scrollToSelectedStyleItem() {
        if let row = cardPresentationStyleItems.firstIndex(of: cardFilter.cardPresentationStyle) {
            let indexPath = IndexPath(row: row, section: 0)
            presenter?.scrollToItem(indexPath: indexPath)
        }
    }
}
