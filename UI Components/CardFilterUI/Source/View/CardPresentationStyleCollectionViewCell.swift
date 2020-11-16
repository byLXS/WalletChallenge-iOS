import UIKit
import WalletPresentationData
import CommonUI
import RSThemeKit

class CardPresentationStyleCollectionViewCell: UICollectionViewCell, NibLoadable {
    
    @IBOutlet weak var smallView: UIView!
    @IBOutlet weak var mediumView: UIView!
    
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
    }

}

class SmallView: UIView {
    
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
        backgroundColor = theme.separatorColor
    }
}
