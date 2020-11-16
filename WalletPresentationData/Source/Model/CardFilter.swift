import Foundation

public protocol CardFilterDelegate: class {
    func apply(filter: CardFilter)
}

public enum CardPresentationStyle {
    case small
    case medium
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
    
    public init(cardPresentationStyle: CardPresentationStyle, cardType: CardFilterType) {
        self.cardPresentationStyle = cardPresentationStyle
        self.cardType = cardType
    }
}
