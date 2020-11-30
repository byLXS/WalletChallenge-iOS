import UIKit

extension SettingsViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let type = interactor?.getType(indexPath: indexPath) else { return 0 }
        switch type {
        case .profile:
            return 81
        default:
            return 44
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let type = interactor?.getType(indexPath: indexPath) else { return }
        switch type {
        case .decoration:
            router?.pushDecoration()
        case .favourites:
            router?.pushFavouritesList()
        case .folders:
            router?.pushFolders()
        default:
            break
        }
    }
    
}
