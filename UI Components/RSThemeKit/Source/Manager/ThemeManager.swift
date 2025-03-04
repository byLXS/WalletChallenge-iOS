import UIKit

public class ThemeManager {
    private static let themeIndexKey = "ThemeIndex"
    
    static var isDarkAppearance: Bool {
        if #available(iOS 13, *) {
            return UIScreen.main.traitCollection.userInterfaceStyle == .dark
        }
        return false
    }
    
    static public var currentTheme: ThemeModel {
        guard let identifier = UserDefaults.standard.string(forKey: themeIndexKey) else { return ThemeType("system").getThemeModel() }
        
        let type = ThemeType(identifier)
        
        return type.getThemeModel()
    }
    
    static public var isSystemTheme: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isSystemTheme")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isSystemTheme")
            setSystem(isSystemTheme)
        }
    }
    
    static public var customTheme: ThemeModel? {
        get {
            return UserDefaults.standard.customThemeForKey(key: "customTheme")
        }
        set {
            if let themeCodable = newValue?.getCodable() {
                UserDefaults.standard.saveCustomTheme(themeCodable, forKey: "customTheme")
            }
        }
    }
    
    private static func setSystem(_ value: Bool) {
        if value {
            setTheme(type: .system)
        } else {
            setTheme(type: isDarkAppearance ? .dark : .light)
        }
    }
    
    static public func setTheme(type: ThemeType) {
        let identifier = type.identifier()
        UserDefaults.standard.set(identifier, forKey: themeIndexKey)
        switch type {
        case .custom(let theme):
            customTheme = theme
        default:
            break
        }
        
        animation()
    }
    
    private static func animation() {
        NotificationCenter.default.post(name: .themeUpdated, object: nil)
        let window = UIApplication.shared.delegate!.window!!
        UIView.transition(
            with: window,
            duration: 0.3,
            options: [.transitionCrossDissolve],
            animations: {},
            completion: nil
        )
    }
    
    static public func addThemeObserver(_ observer: Any, selector: Selector) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: .themeUpdated, object: nil)
    }
}

