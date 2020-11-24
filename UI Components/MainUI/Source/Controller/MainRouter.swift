import Foundation
import UIKit
import CommonUI
import RSThemeKit
import CardDetailUI
import CardFilterUI
import SettingsUI

class MainRouter {
    
    var viewController: MainViewController?
    
    func presentSettings() {
        guard let interactor = viewController?.interactor else { return }
        let vc = SettingsBuilder.getScreen(accountWorker: interactor.accountWorker)
        let navC = ThemeNavigationController(rootViewController: vc)
        viewController?.present(navC, animated: true, completion: nil)
    }
    
    func presentCardDetail(indexPath: IndexPath) {
        guard let interactor = viewController?.interactor else { return }
        let card = interactor.getCard(indexPath: indexPath)
        guard let cardView = (viewController?.collectionView.cellForItem(at: indexPath) as? CardLargeCollectionViewCell)?.cardView else { return }
        let vc = CardDetailBuilder.getScreen(card: card)
        viewController?.presentCard(vc, cardView: cardView)
    }
    
    func presentFilterScreen() {
        guard let viewController = viewController, let interactor = viewController.interactor else { return }
        let vc = CardFilterBuilder.getScreen(delegate: viewController, cardFilter: interactor.cardFilter)
        viewController.presentAsLark(vc, height: 500, completion: nil)
    }
    
}
