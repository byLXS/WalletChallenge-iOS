import UIKit
import RSThemeKit
import WalletPresentationData

public protocol CardLargeViewDelegate: class {
    func tapCard(cardView: CardView, card: Card)
}

public class CardLargeCollectionViewCell: ThemeCollectionCell, CardProtocol {
  
    public weak var cardView: CardView?
    
    static public var identifier = "CardLargeCollectionViewCell"
    
    public var card: Card?
    
    public weak var delegate: CardLargeViewDelegate?
    
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
            cardView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapCard)))
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

    @objc func tapCard() {
        guard let card = card, let cardView = cardView else { return }
        delegate?.tapCard(cardView: cardView, card: card)
    }
}
