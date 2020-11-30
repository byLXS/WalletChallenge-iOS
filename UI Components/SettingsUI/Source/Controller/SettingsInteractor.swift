import Foundation
import WalletCore

protocol SettingsInteractorProtocol {
    var accountWorker: AccountWorker { get }
    func numberOfSections() -> Int
    func numberOfRowsInSection(section: Int) -> Int
    func getType(indexPath: IndexPath) -> SettingsPresentationType
}
class SettingsInteractor: SettingsInteractorProtocol {
    
    var presenter: SettingsPresenterProtocol?
    var accountWorker: AccountWorker
    
    var displayItems = [SettingsSection]()
    
    init(accountWorker: AccountWorker) {
        self.accountWorker = accountWorker
        appendItems()
        accountWorker.fetchFolders { (_) in} completionFailure: { (_) in}
    }
    
    func appendItems() {
        self.displayItems = []
        self.displayItems.append(SettingsSection.section0(rows: [.profile]))
        self.displayItems.append(SettingsSection.section1(rows: [.favourites, .folders, .statistics]))
        self.displayItems.append(SettingsSection.section2(rows: [.language, .decoration]))
    }
    
    func numberOfSections() -> Int {
        return displayItems.count
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return displayItems[section].countRows
    }
    
    func getType(indexPath: IndexPath) -> SettingsPresentationType {
        let section = displayItems[indexPath.section]
        return section.getType(index: indexPath.row)
    }
}
