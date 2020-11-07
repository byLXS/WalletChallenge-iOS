import Foundation
import WalletCore

public class MainBuilder {
    
    static public func getScreen(accountWorker: AccountWorker) -> MainViewController {
        let viewController = MainViewController()
        let interactor = MainInteractor(accountWorker: accountWorker)
        let presenter = MainPresenter()
        let router = MainRouter()
        router.viewController = viewController
        presenter.viewController = viewController
        interactor.presenter = presenter
        viewController.interactor = interactor
        viewController.router = router
        return viewController
    }
}
