import Foundation
import WalletPresentationData

public class CardFilterBuilder {
    
    public static func getScreen(delegate: CardFilterDelegate, cardFilter: CardFilter) -> CardFilterViewController {
        let viewController = CardFilterViewController()
        let interactor = CardFilterInteractor(cardFilter: cardFilter)
        let presenter = CardFilterPresenter()
        let router = CardFilterRouter()
        router.viewController = viewController
        presenter.viewController = viewController
        interactor.presenter = presenter
        viewController.interactor = interactor
        viewController.router = router
        viewController.delegate = delegate
        return viewController
    }
}
