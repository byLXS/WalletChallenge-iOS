import Foundation

protocol FavouritesListPresenterProtocol {
    func reloadList()
}

class FavouritesListPresenter: FavouritesListPresenterProtocol {
    
    var viewController: FavouritesListDisplayLogic?
    
    func reloadList() {
        viewController?.reloadList()
    }
}
