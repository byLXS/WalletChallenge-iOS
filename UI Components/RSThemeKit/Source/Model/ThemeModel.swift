import Foundation
import UIKit

public struct ThemeModel {
    public var identifier: String
    public let textColor: UIColor
    public let detailTextColor: UIColor
    public let tintColor: UIColor
    public let switchTintColor: UIColor
    public let backgroundColor: UIColor
    public let tableViewColor: UIColor
    public let cellBackgroundColor: UIColor
    public let separatorColor: UIColor
    public let navigationBarColor: UIColor
    public let statusBarStyle: UIStatusBarStyle
    public let indicatorStyle: UIScrollView.IndicatorStyle
    public let selectionStyleColor: UIColor
    public let accessoryTypeViewColor: UIColor
    public let switchBackgroundColor: UIColor
    public let keyboardAppearance: UIKeyboardAppearance
    public let blurEffect: UIBlurEffect
    public let stackViewDisabled: UIColor
    public let searchBarBackgroundColor: UIColor
    public let errorColor: UIColor
    
    public init(identifier: String, textColor: UIColor, detailTextColor: UIColor, tintColor: UIColor, switchTintColor: UIColor, backgroundColor: UIColor, tableViewColor: UIColor, cellBackgroundColor: UIColor, separatorColor: UIColor, navigationBarColor: UIColor, statusBarStyle: UIStatusBarStyle, indicatorStyle: UIScrollView.IndicatorStyle, selectionStyleColor: UIColor, accessoryTypeViewColor: UIColor, switchBackgroundColor: UIColor, keyboardAppearance: UIKeyboardAppearance, blurEffect: UIBlurEffect, stackViewDisabled: UIColor, searchBarBackgroundColor: UIColor, errorColor: UIColor) {
        self.identifier = identifier
        self.textColor = textColor
        self.detailTextColor = detailTextColor
        self.tintColor = tintColor
        self.switchTintColor = switchTintColor
        self.backgroundColor = backgroundColor
        self.tableViewColor = tableViewColor
        self.cellBackgroundColor = cellBackgroundColor
        self.separatorColor = separatorColor
        self.navigationBarColor = navigationBarColor
        self.statusBarStyle = statusBarStyle
        self.indicatorStyle = indicatorStyle
        self.selectionStyleColor = selectionStyleColor
        self.accessoryTypeViewColor = accessoryTypeViewColor
        self.switchBackgroundColor = switchBackgroundColor
        self.keyboardAppearance = keyboardAppearance
        self.blurEffect = blurEffect
        self.stackViewDisabled = stackViewDisabled
        self.searchBarBackgroundColor = searchBarBackgroundColor
        self.errorColor = errorColor
    }
}
