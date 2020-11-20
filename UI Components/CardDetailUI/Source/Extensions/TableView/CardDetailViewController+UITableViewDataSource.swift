import Foundation
import UIKit
import RSThemeKit

extension CardDetailViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor?.numberOfRowsInSection(section: section) ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = interactor?.getCardDetailItem(indexPath: indexPath)  else { return UITableViewCell() }
        switch item.type {
        case .barcode:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BarcodeTableViewCell.name, for: indexPath) as? BarcodeTableViewCell else { return ThemeTableCell() }
            cell.barcodeImageView.image = (item as? BarcodeDetailItem)?.image
            cell.selectionStyle = .none
            return cell
        case .certificateExpireDate, .certificateValue, .loyaltyBalance, .loyaltyGrade:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CardDetailTextTableViewCell.name, for: indexPath) as? CardDetailTextTableViewCell else { return ThemeTableCell() }
            cell.selectionStyle = .none
            cell.valueLabel?.text = (item as? TextDetailItem)?.value
            cell.titleLabel?.text = item.type.title
            return cell
        }
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return cardDetailHeaderView
    }
}
