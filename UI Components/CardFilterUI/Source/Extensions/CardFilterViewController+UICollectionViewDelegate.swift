import Foundation
import UIKit

extension CardFilterViewController: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let type = CardFilterCollectionType(rawValue: collectionView.tag) ?? .style
        switch type {
        case .style:
            return
        case .category:
            _ = interactor?.selectCategory(indexPath: indexPath)
            categoryCollectionView.reloadItems(at: [indexPath])
        }
        
        
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = Int(targetContentOffset.move().x / (view.frame.width - 40))
        
        
        interactor?.selectItem(index: index)
        setupStackView()
        
    }
    
}
