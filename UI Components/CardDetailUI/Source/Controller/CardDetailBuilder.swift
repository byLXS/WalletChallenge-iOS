import Foundation
import WalletPresentationData

public class CardDetailBuilder {
    
    public static func getScreen(card: Card, isShowTopBar: Bool) -> CardDetailViewController {
        let viewController = CardDetailViewController()
        let interactor = CardDetailInteractor(card: card, isShowTopBar: isShowTopBar)
        viewController.interactor = interactor
        return viewController
    }
}
