import Foundation
import UIKit
import CommonUI
import CardDetailUI
import CardFilterUI

class MainRouter {
    
    var viewController: MainViewController?
    
    func presentCardDetail(indexPath: IndexPath) {
        guard let interactor = viewController?.interactor else { return }
        let card = interactor.getCard(indexPath: indexPath)
        
        guard let subviews = viewController?.collectionView.cellForItem(at: indexPath)?.subviews, let cardView = subviews.compactMap({$0 as? CardView}).first else { return }
        let vc = CardDetailBuilder.getScreen(card: card)
        viewController?.presentCard(vc, cardView: cardView)
    }
    
    func presentFilterScreen() {
        guard let viewController = viewController, let interactor = viewController.interactor else { return }
        let vc = CardFilterBuilder.getScreen(delegate: viewController, cardFilter: interactor.cardFilter)
        viewController.presentAsLark(vc, height: 500, completion: nil)
    }
    
}
