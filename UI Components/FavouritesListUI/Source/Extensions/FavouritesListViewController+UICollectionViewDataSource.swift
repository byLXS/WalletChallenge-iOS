import Foundation
import CommonUI
import UIKit
import WalletPresentationData

extension FavouritesListViewController: UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interactor?.numberOfItemsInSection(section: section) ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardLargeCollectionViewCell.identifier, for: indexPath) as? CardLargeCollectionViewCell else { return UICollectionViewCell() }
        cell.delegate = self
        cell.card = interactor?.getCard(indexPath: indexPath)
        cell.setup()
        cell.addThemeObserver()
        cell.cardView?.imageView.image = nil
        interactor?.loadImage(indexPath: indexPath, completion: { (image) in
            cell.cardView?.imageView.image = image
        })
        return cell
    }
    
    
}

extension FavouritesListViewController: CardLargeViewDelegate {
    public func tapCard(cardView: CardView, card: Card) {
        router?.presentCardDetail(card: card)
    }
}
