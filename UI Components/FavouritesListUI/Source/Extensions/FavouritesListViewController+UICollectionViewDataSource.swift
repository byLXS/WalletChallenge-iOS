import Foundation
import CommonUI
import UIKit

extension FavouritesListViewController: UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interactor?.numberOfItemsInSection(section: section) ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardLargeCollectionViewCell.identifier, for: indexPath) as? CardLargeCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
}
