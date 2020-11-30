import UIKit
import CommonUI
import CardDetailUI
import WalletPresentationData

class FolderItemRouter {
    
    var viewController: FolderItemViewController?
    
    func presentCardDetail(indexPath: IndexPath) {
        guard let interactor = viewController?.interactor else { return }
        let card = interactor.getCard(indexPath: indexPath)
        let vc = CardDetailBuilder.getScreen(card: card, isShowTopBar: false)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func presentCardList() {
        guard let interactor = viewController?.interactor else { return }
        let vc = CardListBuilder.getScreen(cardList: interactor.accountWorker.account.cardList, folder: interactor.getFolder())
        vc.delegate = self
        let navC = vc.withNavigationController()
        viewController?.present(navC, animated: true, completion: nil)
    }
}

extension FolderItemRouter: CardListViewDelegate {
    func folderItemsChanged() {
        viewController?.interactor?.folderUpdated()
        viewController?.tableView?.reloadData()
    }
}
