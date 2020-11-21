import Foundation
import UIKit

extension CardFilterViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let type = CardFilterCollectionType(rawValue: collectionView.tag) ?? .style
        return interactor?.numberOfItemsInSection(type: type, section: section) ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let type = CardFilterCollectionType(rawValue: collectionView.tag) ?? .style
        switch type {
        case .style:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardPresentationStyleCollectionViewCell.name, for: indexPath) as? CardPresentationStyleCollectionViewCell else { return UICollectionViewCell() }
            cell.style = interactor?.getStyle(indexPath: indexPath) ?? .medium
            cell.setup()
            return cell
        case .category:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.name, for: indexPath) as? CategoryCollectionViewCell else { return UICollectionViewCell() }
            let category = interactor?.getCategory(indexPath: indexPath)
            cell.titleLabel.text = category?.type.title
            cell.selectedItem = category?.isSelected ?? false
            return cell
        }
    }
    
    
}
