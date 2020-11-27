import Foundation
import UIKit
import CommonUI

extension MainViewController: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? CardLargeCollectionViewCell else { return }
        cell.setup()
        cell.addThemeObserver()
        cell.cardView?.imageView.image = nil
        interactor?.loadImage(indexPath: indexPath, completion: { (image) in
            cell.cardView?.imageView.image = image
        })
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        router?.presentCardDetail(indexPath: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
}
