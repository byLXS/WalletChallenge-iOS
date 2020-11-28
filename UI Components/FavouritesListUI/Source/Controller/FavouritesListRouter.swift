import UIKit
import CommonUI
import CardDetailUI
import WalletPresentationData

class FavouritesListRouter {
    
    var viewController: FavouritesListViewController?
    
    func presentCardDetail(indexPath: IndexPath) {
        guard let interactor = viewController?.interactor else { return }
        let card = interactor.getCard(indexPath: indexPath)
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
