import UIKit

open class ThemeViewController: UIViewController {
    
    var current = UIStatusBarStyle.default
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13, *) {
            if ThemeManager.isDarkAppearance {
                if ThemeType.light.identifier() == ThemeManager.currentTheme.identifier {
                    current = .darkContent
                }
                return ThemeManager.isSystemTheme ? .lightContent : current
            }
            return ThemeManager.isSystemTheme ? .darkContent : current
        }
        return current
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addThemeObserver()
    }
    
    public func addThemeObserver() {
        ThemeManager.addThemeObserver(self, selector: #selector(changedTheme))
        changedTheme()
    }
    
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        changedTheme()
    }

    @objc func changedTheme() {
        decorator(theme: ThemeManager.currentTheme)
    }
    
    open func decorator(theme: ThemeModel) {
        view.backgroundColor = theme.backgroundColor
        current = theme.statusBarStyle
        setNeedsStatusBarAppearanceUpdate()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
