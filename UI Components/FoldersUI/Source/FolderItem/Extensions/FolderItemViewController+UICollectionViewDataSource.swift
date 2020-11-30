import Foundation
import UIKit
import RSThemeKit
import WalletPresentationData

extension FolderItemViewController: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return interactor?.numberOfSections() ?? 0
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor?.numberOfItemsInSection(section: section) ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let displayItem = interactor?.getDisplayIten(section: indexPath.section) else { return ThemeTableCell() }
        let cell = FolderCell()
        cell.addThemeObserver()
        switch displayItem {
        case .folders:
            cell.accessoryType = .disclosureIndicator
            if let card = interactor?.getCard(indexPath: indexPath) {
                cell.imageView?.image = nil
                cell.textLabel?.text = card.issuer.name
                interactor?.loadImage(indexPath: indexPath, completion: { (image) in
                    cell.imageView?.image = image
//                    let itemSize = CGSize.init(width: 60, height: 36)
//                    UIGraphicsBeginImageContextWithOptions(itemSize, false, UIScreen.main.scale);
//                    let imageRect = CGRect.init(origin: CGPoint.zero, size: itemSize)
//                    cell.imageView?.image!.draw(in: imageRect)
//                    cell.imageView?.image! = UIGraphicsGetImageFromCurrentImageContext()!;
//                    UIGraphicsEndImageContext();
                    cell.layoutSubviews()
                })
            }
        case .addFolder:
            cell.textLabel?.text = Strings.addCards
        }
        return cell
    }
    
}
