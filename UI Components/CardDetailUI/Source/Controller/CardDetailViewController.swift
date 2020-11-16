import UIKit
import RSThemeKit
import CommonUI
import WalletPresentationData

public class CardDetailViewController: ThemeViewController {
    
    @IBOutlet public var cancelButton: UIButton!
    @IBOutlet public var cardView: CardView!
    @IBOutlet public weak var ean13ImageView: UIImageView!
    
    var interactor: CardDetailInteractorProtocol?

    public override func viewDidLoad() {
        super.viewDidLoad()
        cancelButton.setImage(getImage(named: "cancel_circle_image", anyClass: CardLargeCollectionViewCell.self), for: .normal)
        interactor?.getCardImage(completion: { [weak self] (image) in
            self?.cardView.imageView.image = image
        })
        
        cardView.isOpaque = false
        cardView.superEllipse(cornerRadius: 14)
        cardView.imageView.isOpaque = false
        cardView.imageView.contentMode = .scaleToFill
        cardView.addSubview(cardView!.imageView)
        cardView.imageView = cardView!.imageView
        
        ean13ImageView.image = interactor?.generateBarcode()
    }
    
    public init() {
        super.init(nibName: "CardDetailViewController", bundle: Bundle(for: CardDetailViewController.self))
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    @IBAction func skipScreen() {
        self.dismiss(animated: true, completion: nil)
    }

}

extension CardDetailViewController: CardPresentedProtocol {
    public var finalRect: CGRect {
        return cardView.frame
    }
}


extension CardDetailViewController: CardProtocol {
    public func getCardView() -> CardView? {
        return cardView
    }
}
