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
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarHidden(true, animated: false)
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
}
