import Foundation
import UIKit
import CommonUI
import RSThemeKit
import CardDetailUI
import CardFilterUI
import SettingsUI
import WalletPresentationData

class MainRouter {
    
    var viewController: MainViewController?
    
    func presentSettings() {
        guard let interactor = viewController?.interactor else { return }
        let vc = SettingsBuilder.getScreen(accountWorker: interactor.accountWorker)
        let navC = ThemeNavigationController(rootViewController: vc)
        viewController?.present(navC, animated: true, completion: nil)
    }
    
    func presentCardDetail(cardView: CardView, card: Card) {
        let vc = CardDetailBuilder.getScreen(card: card, isShowTopBar: true)
        viewController?.presentCard(vc, cardView: cardView)
    }
    
    func presentFilterScreen() {
        viewController?.statusBar(isHidden: true)
        guard let viewController = viewController, let interactor = viewController.interactor else { return }
        let vc = CardFilterBuilder.getScreen(delegate: viewController, cardFilter: interactor.cardFilter)
        viewController.presentAsLark(vc, height: 500, completion: nil)
    }
    
}
