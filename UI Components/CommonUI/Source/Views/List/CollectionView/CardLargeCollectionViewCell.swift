import UIKit
import RSThemeKit
import WalletPresentationData

public class CardLargeCollectionViewCell: ThemeCollectionCell, CardProtocol {
  
    public weak var cardView: CardView?
    
    static public var identifier = "CardLargeCollectionViewCell"
    
    public func setup() {
        if cardView == nil {
            let view = CardView(frame: CGRect(x: 0, y: 0, width: CardLayout.width, height: CardLayout.height))
            view.isOpaque = false
            self.addSubview(view)
            view.imageView.frame = CGRect(x: 0, y: 0, width: CardLayout.width, height: CardLayout.height)
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
    
    public override func decorator(theme: ThemeModel) {
        super.decorator(theme: theme)
        backgroundColor = .clear
        cardView?.backgroundColor = theme.searchBarBackgroundColor
    }

}
