import UIKit
import CommonUI
import RSThemeKit

open class BarcodeTableViewCell: ThemeTableCell, NibLoadable {
    
    @IBOutlet weak var barcodeImageView: UIImageView!
    
    open override func decorator(theme: ThemeModel) {
        super.decorator(theme: theme)
        backgroundColor = theme.tableViewColor
    }

    
}
