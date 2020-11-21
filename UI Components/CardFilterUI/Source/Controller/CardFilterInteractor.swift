import Foundation
import WalletPresentationData

protocol CardFilterInteractorProtocol {
    var cardFilter: CardFilter { get set }
    var cardPresentationStyleItems: [CardPresentationStyle] { get }
    func numberOfItemsInSection(type: CardFilterCollectionType, section: Int) -> Int
    func getStyle(indexPath: IndexPath) -> CardPresentationStyle
    func getCategory(indexPath: IndexPath) -> CategoryItem
    func selectCategory(indexPath: IndexPath)
    func selectItem(index: Int)
    func scrollToSelectedStyleItem()
    func clearFilter()
}

class CardFilterInteractor: CardFilterInteractorProtocol {
    
    var presenter: CardFilterPresenterProtocol?
    
    let cardPresentationStyleItems: [CardPresentationStyle] = [.medium, .small]
    
    var cardFilter: CardFilter
    
    init(cardFilter: CardFilter) {
        self.cardFilter = cardFilter
    }
    
    func numberOfItemsInSection(type: CardFilterCollectionType, section: Int) -> Int {
        switch type {
        case .style:
            return cardPresentationStyleItems.count
        case .category:
            return self.cardFilter.selectedCategoryItems.count
        }
    }
    
    func getStyle(indexPath: IndexPath) -> CardPresentationStyle {
        return cardPresentationStyleItems[indexPath.row]
    }
    
    func getCategory(indexPath: IndexPath) -> CategoryItem {
        return self.cardFilter.selectedCategoryItems[indexPath.row]
    }
    
    func selectItem(index: Int) {
        let item = cardPresentationStyleItems[index]
        cardFilter.cardPresentationStyle = item
    }
    
    func selectCategory(indexPath: IndexPath) {
        let item = cardFilter.selectedCategoryItems[indexPath.row]
        item.isSelected = !item.isSelected
    }
    
    func scrollToSelectedStyleItem() {
        if let row = cardPresentationStyleItems.firstIndex(of: cardFilter.cardPresentationStyle) {
            let indexPath = IndexPath(row: row, section: 0)
            presenter?.scrollToItem(indexPath: indexPath)
        }
    }
    
    func clearFilter() {
        let categoryList: [CategoryItem] = [CategoryItem(type: .appliances), CategoryItem(type: .buildingMaterials), CategoryItem(type: .goods)]
        self.cardFilter = CardFilter(cardPresentationStyle: .medium, cardType: .all, selectedCategoryItems: categoryList, isSelected: false)
    }
}
