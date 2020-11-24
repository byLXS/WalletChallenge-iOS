import Foundation
import WalletPresentationData

public class FavouritesListBuilder {
    static public func getScreen(cardList: [Card]) -> FavouritesListViewController {
        let viewController = FavouritesListViewController()
        let interactor = FavouritesListInteractor(cardList: cardList)
        let router = FavouritesListRouter()
        router.viewController = viewController
        viewController.interactor = interactor
        viewController.router = router
        return viewController
    }
}
