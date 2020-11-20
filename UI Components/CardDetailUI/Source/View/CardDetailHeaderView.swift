import Foundation
import UIKit
import CommonUI
import RSThemeKit
import WalletPresentationData

class CardDetailHeaderView: UIView, NibLoadable {
    
    @IBOutlet weak var collectionView: ThemeCollectionView!
    @IBOutlet weak var stackView: UIStackView!
    var cardView: CardView?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCardView()
        collectionView.register(CardLargeCollectionViewCell.self, forCellWithReuseIdentifier: CardLargeCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: 0, left: CardLayout.x, bottom: 0, right: 0)
            layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: CardLayout.height)
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
        }
        collectionView.isPagingEnabled = true
    }
    
    func addThemeObserver() {
        ThemeManager.addThemeObserver(self, selector: #selector(changedTheme))
        changedTheme()
    }
    
    @objc func changedTheme() {
        decorator(theme: ThemeManager.currentTheme)
    }
    
    func decorator(theme: ThemeModel) {
        backgroundColor = theme.tableViewColor
        collectionView.backgroundColor = theme.tableViewColor
    }
    
    func setupCardView() {
        if cardView == nil {
            let view = CardView(frame: CGRect(x: CardLayout.x, y: 0, width: CardLayout.width, height: CardLayout.height))
            view.isOpaque = false
            view.superEllipse(cornerRadius: 14)
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
}
