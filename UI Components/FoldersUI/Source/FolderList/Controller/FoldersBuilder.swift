import Foundation
import WalletCore

public class FoldersBuilder {
    
    public static func getScreen(accountWorker: AccountWorker) -> FoldersViewController {
        let viewController = FoldersViewController()
        let interactor = FoldersInteractor(accountWorker: accountWorker)
        let router = FoldersRouter()
        router.viewController = viewController
        viewController.interactor = interactor
        viewController.router = router
        return viewController
    }
}
