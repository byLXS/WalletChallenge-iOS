import Foundation
import WalletPresentationData

public class CardListBuilder {
    public static func getScreen(cardList: [Card], folder: Folder) -> CardListViewController {
        let viewController = CardListViewController()
        let interactor = CardListInteractor(cardList: cardList, folder: folder)
        viewController.interactor = interactor
        return viewController
    }
}
