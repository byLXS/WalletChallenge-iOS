import UIKit
import CommonUI
import RSThemeKit

class CategoryCollectionViewCell: ThemeCollectionCell, NibLoadable {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var selectedItem = false {
        didSet {
            let themeType = ThemeType.dark
            let darkTheme = themeType.getDarkTheme()
            decorator(theme: darkTheme)
        }
    }

    override func decorator(theme: ThemeModel) {
        super.decorator(theme: theme)
        backgroundColor = selectedItem ? theme.tintColor : theme.cellBackgroundColor
        titleLabel.textColor = theme.textColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        superEllipse(cornerRadius: 14)
    }
}
