import Foundation
import WalletPresentationData

public class CardDetailBuilder {
    
    public static func getScreen(card: Card) -> CardDetailViewController {
        let viewController = CardDetailViewController()
        let interactor = CardDetailInteractor(card: card)
        viewController.interactor = interactor
        return viewController
    }
}
