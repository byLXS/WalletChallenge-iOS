import Foundation

public protocol CardFilterDelegate: class {
    func apply(filter: CardFilter)
}

public enum CardPresentationStyle {
    case small
    case medium
}

public class CategoryItem {
    public var type: CategoryType
    public var isSelected: Bool
    
    public init(type: CategoryType, isSelected: Bool = false) {
        self.type = type
        self.isSelected = isSelected
    }
    
    public static func getDefaultItems() -> [CategoryItem] {
        return [CategoryItem(type: .mostUsed), CategoryItem(type: .appliances), CategoryItem(type: .buildingMaterials), CategoryItem(type: .goods)]
    }
}

public enum CardFilterType: Int {
    case all
    case loyalty
    case certificate
    
    public var title: String {
        switch self {
        case .all:
            return Strings.all
        case .loyalty:
            return Strings.loyalty
        case .certificate:
            return Strings.certificate
        }
    }
}

public struct CardFilter {
    public var cardPresentationStyle: CardPresentationStyle
    public var cardType: CardFilterType
    public var selectedCategoryItems: [CategoryItem]
    public var isSelected: Bool
    
    public init(cardPresentationStyle: CardPresentationStyle, cardType: CardFilterType, selectedCategoryItems: [CategoryItem], isSelected: Bool) {
        self.cardPresentationStyle = cardPresentationStyle
        self.cardType = cardType
        self.selectedCategoryItems = selectedCategoryItems
        self.isSelected = isSelected
    }
}
