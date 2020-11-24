import UIKit
import CommonUI
import CardDetailUI

class FavoritesListRouter {
    
    var viewController: FavoritesListViewController?
    
    func presentCardDetail(indexPath: IndexPath) {
        guard let interactor = viewController?.interactor else { return }
        let card = interactor.getCard(indexPath: indexPath)
        let vc = CardDetailBuilder.getScreen(card: card)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
