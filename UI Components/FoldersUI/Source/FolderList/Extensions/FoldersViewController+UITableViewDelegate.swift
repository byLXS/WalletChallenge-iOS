import Foundation
import UIKit

extension FoldersViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let item = interactor?.getDisplayIten(section: indexPath.section) else { return }
        switch item {
        case .folders:
            router?.pushFolderItem(indexPath: indexPath)
        case .addFolder:
            addFolder()
        }
        
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            interactor?.removeFolder(indexPath: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
            setupNavigationBar()
        }
    }
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let item = interactor?.getDisplayIten(section: indexPath.section) ?? .addFolder
        return item != .addFolder
    }
}
