import Foundation
import UIKit

extension CardFilterViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interactor?.numberOfItemsInSection(section: section) ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardPresentationStyleCollectionViewCell.name, for: indexPath) as? CardPresentationStyleCollectionViewCell else { return UICollectionViewCell() }
        cell.style = interactor?.getStyle(indexPath: indexPath) ?? .medium
        cell.setup()
        return cell
    }
    
    
}
