import UIKit
import CommonUI
import CardDetailUI

class FavouritesListRouter {
    
    var viewController: FavouritesListViewController?
    
    func presentCardDetail(indexPath: IndexPath) {
        guard let interactor = viewController?.interactor else { return }
        let card = interactor.getCard(indexPath: indexPath)
        let vc = CardDetailBuilder.getScreen(card: card, isShowTopBar: false)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
