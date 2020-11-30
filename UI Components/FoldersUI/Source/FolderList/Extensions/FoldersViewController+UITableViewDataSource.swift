import Foundation
import UIKit
import RSThemeKit
import WalletPresentationData

extension FoldersViewController: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return interactor?.numberOfSections() ?? 0
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        interactor?.numberOfItemsInSection(section: section) ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let displayItem = interactor?.getDisplayIten(section: indexPath.section) else { return ThemeTableCell() }
        let cell = FolderCell()
        cell.addThemeObserver()
        switch displayItem {
        case .folders:
            cell.accessoryType = .disclosureIndicator
            if let folder = interactor?.getFolder(indexPath: indexPath) {
                cell.textLabel?.text = folder.name
            }
        case .addFolder:
            cell.textLabel?.text = Strings.createNewFolder
        }
        
        
        return cell
    }

}

class FolderCell: ThemeTableCell {
    
    override func decorator(theme: ThemeModel) {
        super.decorator(theme: theme)
        backgroundColor = theme.cellBackgroundColor
    }
}
