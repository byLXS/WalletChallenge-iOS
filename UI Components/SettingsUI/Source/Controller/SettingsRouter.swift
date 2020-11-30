import Foundation
import DecorationUI
import FavouritesListUI
import FoldersUI
import WalletCore
import UIKit

class SettingsRouter {
    
    var viewController: SettingsViewController?
    
    func pushDecoration() {
        let vc = DecorationBuilder.getScreen()
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushFavouritesList() {
        guard let viewController = viewController, let accountWorker = viewController.interactor?.accountWorker else { return }
        let vc = FavouritesListBuilder.getScreen(cardList: accountWorker.account.cardList.filter({$0.isFavourites == true}))
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushFolders() {
        guard let viewController = viewController, let accountWorker = viewController.interactor?.accountWorker else { return }
        let vc = FoldersBuilder.getScreen(accountWorker: accountWorker)
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
