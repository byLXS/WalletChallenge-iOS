import Foundation
import UIKit
import WalletCore
import CommonUI
import MainUI
import RSThemeKit

open class WRootController: ThemeNavigationController {
    
    var rootTabBarController: ThemeTabBarController?
    var mainController: MainViewController?
    
    let accountWorker = AccountWorker(account: Account(id: 0))
    
    var networkNotReachable = false
    let reachability = try! Reachability()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarHidden(true, animated: false)
        networkReachabilityConnecting()
    }
    
    public func addRootController() {
        let tabBarController = ThemeTabBarController()
        var controllers: [UINavigationController] = []
        
        
        let mainVC = MainBuilder.getScreen(accountWorker: accountWorker)
        let mainNavC = mainVC.withNavigationController()
        self.mainController = mainVC
        controllers.append(mainNavC)
        
        tabBarController.tabBar.isHidden = true
        tabBarController.setViewControllers(controllers, animated: false)
        
        self.rootTabBarController = tabBarController
        self.pushViewController(tabBarController, animated: false)
    }
    
    func networkReachabilityConnecting() {
       NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            print("Bildirici başlatılamadı")
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi:
            if networkNotReachable == true {
                networkNotReachable = false
                mainController?.fetchCardList()
            }
        case .cellular:
            if networkNotReachable == true {
                networkNotReachable = false
                mainController?.fetchCardList()
            }
        case .unavailable:
            networkNotReachable = true
        case .none:
            print("none")
        }
    }
}
