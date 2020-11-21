import UIKit
import CommonUI
import WalletPresentationData
import RSThemeKit

class MainCollectionReusableView: UICollectionReusableView, NibLoadable {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var filterButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        addThemeObserver()
        titleLabel.text = Strings.myCard
        filterButton.setTitle(Strings.filter, for: .normal)
        
    }
    
    func addThemeObserver() {
        ThemeManager.addThemeObserver(self, selector: #selector(changedTheme))
        changedTheme()
    }
    
    @objc func changedTheme() {
        decorator(theme: ThemeManager.currentTheme)
    }
    
    func decorator(theme: ThemeModel) {
        backgroundColor = theme.backgroundColor
    }
    
}
