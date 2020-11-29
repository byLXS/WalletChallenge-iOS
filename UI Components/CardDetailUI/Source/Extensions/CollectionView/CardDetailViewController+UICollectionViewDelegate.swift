import Foundation
import UIKit
import CommonUI 
extension CardDetailViewController: UICollectionViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 || scrollView.contentOffset.y < 0 {
            scrollView.contentOffset.y = 0
        }
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = Int(targetContentOffset.move().x / (view.frame.width - 40))
        
        
        interactor?.selectItem(index: index)
        setupStackView()
        
    }
    
}
