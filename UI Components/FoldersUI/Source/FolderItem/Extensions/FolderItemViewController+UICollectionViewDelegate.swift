import Foundation
import UIKit

extension FolderItemViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    
        guard let item = interactor?.getDisplayIten(section: indexPath.section) else { return }
        switch item {
        case .folders:
            router?.presentCardDetail(indexPath: indexPath)
        case .addFolder:
            addCard()
        }
    }
    
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            interactor?.removeCardNumber(indexPath: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
            setupNavigationBar()
        }
    }
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let item = interactor?.getDisplayIten(section: indexPath.section) ?? .addFolder
        return item != .addFolder
    }
}
