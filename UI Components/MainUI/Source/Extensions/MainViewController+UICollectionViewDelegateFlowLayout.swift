import Foundation
import UIKit

//extension MainViewController: UICollectionViewDelegateFlowLayout {
//
//    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: UIScreen.main.bounds.size.width - 80, height: 200)
//    }
//}


private let spacing : CGFloat = 10
private let screenWidth = UIScreen.main.bounds.maxX
private let cellHeight : CGFloat = 200
private let smallSize = CGSize(width: (screenWidth - 3 * spacing) / 2, height: cellHeight)
private let mediumSize = CGSize(width: UIScreen.main.bounds.size.width - 80, height: 200)

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
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
        return UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
}
