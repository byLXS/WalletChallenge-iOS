import UIKit
import CommonUI
import CardDetailUI
import WalletPresentationData

class FavouritesListRouter {
    
    var viewController: FavouritesListViewController?
    
    func presentCardDetail(card: Card) {
        let vc = CardDetailBuilder.getScreen(card: card, isShowTopBar: false)
        vc.delegate = self
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}

extension FavouritesListRouter: CardDetailViewDelegate {
    func cardChanged(_ card: Card) {
        viewController?.interactor?.cardChanged(card: card)
    }
}
