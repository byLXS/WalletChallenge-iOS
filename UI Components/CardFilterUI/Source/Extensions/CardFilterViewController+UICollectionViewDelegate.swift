import Foundation
import UIKit

extension CardFilterViewController: UICollectionViewDelegate {
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = Int(targetContentOffset.move().x / (view.frame.width - 40))
        
        
        interactor?.selectItem(index: index)
        setupStackView()
        
    }
    
}
