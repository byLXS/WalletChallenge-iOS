import UIKit
import WalletPresentationData
import CommonUI
import RSThemeKit

class CardPresentationStyleCollectionViewCell: UICollectionViewCell, NibLoadable {
    
    @IBOutlet weak var smallView: CardStyleView!
    @IBOutlet weak var mediumView: CardStyleView!
    
    var style: CardPresentationStyle = .medium

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup() {
        switch style {
        case .small:
            mediumView.isHidden = true
            smallView.isHidden = false
        case .medium:
            mediumView.isHidden = false
            smallView.isHidden = true
        }
        mediumView.defaultCornerRadius = 22
    }

}

class CardStyleView: SuperEllipseView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
        backgroundColor = theme.cellBackgroundColor
    }
}
