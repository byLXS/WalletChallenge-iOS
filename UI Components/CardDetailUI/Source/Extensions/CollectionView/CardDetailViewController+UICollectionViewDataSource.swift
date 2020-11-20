import Foundation
import UIKit
import CommonUI

extension CardDetailViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardLargeCollectionViewCell.identifier, for: indexPath) as? CardLargeCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
    
    
}
