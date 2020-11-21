import Foundation
import UIKit
import WalletPresentationData

extension CardFilterViewController: UICollectionViewDelegateFlowLayout {
    
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let type = CardFilterCollectionType(rawValue: collectionView.tag) ?? .style
        switch type {
        case .style:
            return CGSize(width: UIScreen.main.bounds.width - 40, height: 150)
        case .category:
            guard let category = interactor?.getCategory(indexPath: indexPath) else { return .zero }
            let width = category.type.title.width(withConstrainedHeight: 13, font: UIFont.systemFont(ofSize: 13, weight: .semibold)) + 24
            return CGSize(width: width, height: 30)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let type = CardFilterCollectionType(rawValue: collectionView.tag) ?? .style
        switch type {
        case .style:
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        case .category:
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let type = CardFilterCollectionType(rawValue: collectionView.tag) ?? .style
        switch type {
        case .style:
            return 8
        case .category:
            return .zero
        }
    }
}
