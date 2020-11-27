import Foundation
import UIKit
import CommonUI 
extension CardDetailViewController: UICollectionViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 || scrollView.contentOffset.y < 0 {
            scrollView.contentOffset.y = 0
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? CardLargeCollectionViewCell else { return }
        cell.setup()
        cardDetailHeaderView.cardView = cell.cardView
        cell.addThemeObserver()
        cell.cardView?.imageView.image = nil
        interactor?.loadImage(indexPath: indexPath, completion: { (image) in
            cell.cardView?.imageView.image = image
        })
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = Int(targetContentOffset.move().x / (view.frame.width - 40))
        
        
        interactor?.selectItem(index: index)
        setupStackView()
        
    }
    
}
