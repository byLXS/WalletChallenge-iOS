import UIKit
import RSThemeKit

extension UIViewController {
    
    public func withNavigationController(taBarTitle: String? = nil, title: String? = nil, image: UIImage? = nil) -> ThemeNavigationController {
        
        let navigationController = ThemeNavigationController(rootViewController: self)
        navigationController.tabBarItem.title = taBarTitle
        navigationController.tabBarItem.image = image
        self.navigationController?.navigationBar.topItem?.title = title
        return navigationController
        
    }
    
    public var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height
    }
    
    public var navigationBarHeight: CGFloat {
        return self.navigationController?.navigationBar.frame.height ?? 0.0
    }
}
