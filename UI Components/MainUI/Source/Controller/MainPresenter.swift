import Foundation

protocol MainPresenterProtocol {
    func reloadList()
}

class MainPresenter: MainPresenterProtocol {
    
    var viewController: MainDisplayLogic?
    
    func reloadList() {
        viewController?.reloadList()
    }
}
