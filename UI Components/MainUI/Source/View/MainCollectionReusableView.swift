import UIKit
import CommonUI
import WalletPresentationData

class MainCollectionReusableView: UICollectionReusableView, NibLoadable {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var filterButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.text = Strings.myCard
        filterButton.setTitle(Strings.filter, for: .normal)
    }
    
}
