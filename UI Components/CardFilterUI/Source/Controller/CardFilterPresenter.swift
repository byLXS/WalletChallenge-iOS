import Foundation

protocol CardFilterPresenterProtocol {
    func scrollToItem(indexPath: IndexPath)
}

class CardFilterPresenter: CardFilterPresenterProtocol {
    
    var viewController: CardFilterDisplayLogic?
    
    func scrollToItem(indexPath: IndexPath) {
        viewController?.scrollToItem(indexPath: indexPath)
    }
}
