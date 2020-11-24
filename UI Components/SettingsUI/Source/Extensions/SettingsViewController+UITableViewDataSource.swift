import Foundation
import UIKit
import RSThemeKit

extension SettingsViewController: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return interactor?.numberOfSections() ?? 0
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor?.numberOfRowsInSection(section: section) ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let model = interactor?.getType(indexPath: indexPath) else { return ThemeTableCell() }
        switch model {
        case .profile:
            let cellProfile = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.name, for: indexPath) as! ProfileTableViewCell
            cellProfile.userNameLabel.text = "Robert Shaginyan"
            cellProfile.telegramUsernameLabel.text = "tg: @byLXS"
            cellProfile.userImageView.image = getSettingsImage(presentationType: model)
            return cellProfile
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.name, for: indexPath) as? TextTableViewCell else { return ThemeTableCell() }
            cell.textLabel?.text = model.title
            cell.imageView?.image = getSettingsImage(presentationType: model)
            cell.accessoryType = model.accessoryType
            return cell
        }
        
    }
    
    
}
