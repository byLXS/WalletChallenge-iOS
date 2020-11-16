import Foundation
import UIKit
import RSThemeKit

open class AddButton: UIButton {
    
    public func setup() {
        self.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        self.contentEdgeInsets.left = 10
        self.contentEdgeInsets.right = 10
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        addThemeObserver()
    }
    
    func addThemeObserver() {
        ThemeManager.addThemeObserver(self, selector: #selector(changedTheme))
        changedTheme()
    }
    
    @objc func changedTheme() {
        decorator(theme: ThemeManager.currentTheme)
    }
    
    func decorator(theme: ThemeModel) {
        backgroundColor = theme.tintColor
        setTitleColor(.white, for: .normal)
    }
}
