import UIKit
import RSThemeKit

public class CardLargeCollectionViewCell: ThemeCollectionCell, CardProtocol {
  
    public weak var cardView: CardView?
    
    static public var identifier = "CardLargeCollectionViewCell"
    
    public func setup() {
        if cardView == nil {
            let view = CardView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 80, height: 200))
            view.isOpaque = false
            self.addSubview(view)
            view.superEllipse(cornerRadius: 14)
            view.imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 80, height: 200)
            view.imageView.center = view.center
            view.imageView.isOpaque = false
            view.imageView.contentMode = .scaleToFill
            view.addSubview(view.imageView)
            cardView?.addSubview(view)
            cardView?.imageView = view.imageView
            cardView = view
        }
    }
    
    public func getCardView() -> CardView? {
        return cardView
    }

}
