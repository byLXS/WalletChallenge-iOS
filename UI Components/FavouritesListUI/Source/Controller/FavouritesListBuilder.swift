import Foundation
import WalletPresentationData

public class FavouritesListBuilder {
    static public func getScreen(cardList: [Card]) -> FavouritesListViewController {
        let viewController = FavouritesListViewController()
        let interactor = FavouritesListInteractor(cardList: cardList)
        let presenter = FavouritesListPresenter()
        let router = FavouritesListRouter()
        presenter.viewController = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        viewController.interactor = interactor
        viewController.router = router
        return viewController
    }
}
