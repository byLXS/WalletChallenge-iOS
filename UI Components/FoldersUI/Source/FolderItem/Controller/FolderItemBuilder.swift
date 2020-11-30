import Foundation
import WalletCore
import WalletPresentationData

public class FolderItemBuilder {
    public static func getScreen(accountWorker: AccountWorker, folder: Folder) -> FolderItemViewController {
        let viewController = FolderItemViewController()
        let interactor = FolderItemInteractor(accountWorker: accountWorker, folder: folder)
        let router = FolderItemRouter()
        router.viewController = viewController
        viewController.interactor = interactor
        viewController.router = router
        return viewController
    }
}
