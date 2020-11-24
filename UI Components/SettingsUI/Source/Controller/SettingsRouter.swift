import Foundation
import DecorationUI
import FavoritesListUI
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
        UIScreen.main.setBrightness(to: 10, duration: 0.6, ticksPerSecond: 120)
    }
}
