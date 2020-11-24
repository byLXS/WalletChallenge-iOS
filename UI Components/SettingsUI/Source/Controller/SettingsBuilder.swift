import Foundation
import WalletCore

public class SettingsBuilder {
    
    static public func getScreen(accountWorker: AccountWorker) -> SettingsViewController {
        let viewController = SettingsViewController()
        let interactor = SettingsInteractor(accountWorker: accountWorker)
        let presenter = SettingsPresenter()
        let router = SettingsRouter()
        router.viewController = viewController
        presenter.viewController = viewController
        interactor.presenter = presenter
        viewController.router = router
        viewController.interactor = interactor
        return viewController
        
    }
}
