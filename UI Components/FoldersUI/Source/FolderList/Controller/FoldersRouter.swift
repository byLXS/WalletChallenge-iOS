import Foundation

class FoldersRouter {
    
    var viewController: FoldersViewController?
    
    func pushFolderItem(indexPath: IndexPath) {
        guard let viewController = viewController, let interactor = viewController.interactor else { return }
        let folder = interactor.getFolder(indexPath: indexPath)
        let vc = FolderItemBuilder.getScreen(accountWorker: interactor.accountWorker, folder: folder)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
