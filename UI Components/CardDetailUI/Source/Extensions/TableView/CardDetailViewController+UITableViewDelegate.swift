import Foundation
import UIKit
import WalletPresentationData

extension CardDetailViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CardLayout.height + 23
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let item = interactor?.getCardDetailItem(indexPath: indexPath) else { return 70 }
        switch item.type {
        case .barcode:
            return UIScreen.main.bounds.height * 0.15
            
        default:
            return 70
        }
    }
}
