import UIKit
import RSThemeKit
import CommonUI

class CardDetailTextTableViewCell: ThemeTableCell, NibLoadable {

    @IBOutlet weak var containerView: SuperEllipseView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    open override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func decorator(theme: ThemeModel) {
        super.decorator(theme: theme)
        backgroundColor = theme.tableViewColor
        titleLabel?.textColor = theme.textColor
        valueLabel?.textColor = theme.textColor
        containerView.backgroundColor = theme.cellBackgroundColor
    }
}
