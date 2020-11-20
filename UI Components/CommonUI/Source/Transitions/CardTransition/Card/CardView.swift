import Foundation
import UIKit

open class CardView: SuperEllipseView {
    
    public var imageView = UIImageView()
    
    open override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public static func getCardCopy(cardView: CardView) -> CardView {
        let copyCardView = CardView(frame: cardView.frame)
        copyCardView.imageView.image = cardView.imageView.image
        copyCardView.addSubview(copyCardView.imageView)
        return copyCardView
    }
    
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
    }
    
}
