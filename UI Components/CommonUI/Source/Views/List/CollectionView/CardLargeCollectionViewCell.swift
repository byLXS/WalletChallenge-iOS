import UIKit
import RSThemeKit

public class CardLargeCollectionViewCell: ThemeCollectionCell {
    
    public weak var imageView: UIImageView?
    
    static public var identifier = "CardLargeCollectionViewCell"
    
    public func setup() {
        superEllipse(cornerRadius: 14)
        if imageView == nil {
            let view = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 40, height: 200))
            view.isOpaque = false
            view.contentMode = .scaleAspectFit
            self.addSubview(view)
            imageView = view
        }
    }

}
