import Foundation
import WalletPresentationData

public class FavoritesListBuilder {
    static public func getScreen(cardList: [Card]) -> FavoritesListViewController {
        let viewController = FavoritesListViewController()
        let interactor = FavoritesListInteractor(cardList: cardList)
        let router = FavoritesListRouter()
        router.viewController = viewController
        viewController.interactor = interactor
        viewController.router = router
        return viewController
    }
}
