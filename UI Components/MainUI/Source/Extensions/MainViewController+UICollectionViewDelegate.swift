import Foundation
import UIKit
import CommonUI

extension MainViewController: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? CardLargeCollectionViewCell else { return }
        cell.setup()
        cell.imageView?.image = nil
        interactor?.loadImage(indexPath: indexPath, completion: { (image) in
            cell.imageView?.image = image
        })
    }
}
