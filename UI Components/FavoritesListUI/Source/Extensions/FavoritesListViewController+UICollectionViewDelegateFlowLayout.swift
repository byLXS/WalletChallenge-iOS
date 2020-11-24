import Foundation
import UIKit
import WalletPresentationData

private let spacing : CGFloat = 10
private let screenWidth = UIScreen.main.bounds.maxX
private let smallSize = CGSize(width: (screenWidth - 3 * spacing) / 2, height: CardLayout.height)
private let mediumSize = CGSize(width: CardLayout.width, height: CardLayout.height)

extension FavoritesListViewController: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let style = interactor?.cardFilter.cardPresentationStyle ?? .medium
        switch style {
        case .small:
            return smallSize
        case .medium:
            return mediumSize
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: spacing, bottom: spacing, right: spacing)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
}
