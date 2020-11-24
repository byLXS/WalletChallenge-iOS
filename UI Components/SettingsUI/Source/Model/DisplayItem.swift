import Foundation
import UIKit
import WalletPresentationData

enum SettingsPresentationType {
    case profile
    case statistics
    case language
    case decoration
    case favourites
    
    
    var title: String {
        switch self {
        case .profile:
            return ""
        case .statistics:
            return Strings.statistics
        case .language:
            return Strings.language
        case .decoration:
            return Strings.decoration
        case .favourites:
            return Strings.favourites
        }
    }
    
    var accessoryType: UITableViewCell.AccessoryType {
        switch self {
        case .profile:
            return .none
        case .statistics:
            return .disclosureIndicator
        case .language:
            return .disclosureIndicator
        case .decoration:
            return .disclosureIndicator
        case .favourites:
            return .disclosureIndicator
        }
    }
}

enum SettingsSection {
    case section0(rows: [SettingsPresentationType])
    case section1(rows: [SettingsPresentationType])
    case section2(rows: [SettingsPresentationType])
    case section3(rows: [SettingsPresentationType])
    case section4(rows: [SettingsPresentationType])
    case section5(rows: [SettingsPresentationType])
    
    //refactoring
    
    var countRows: Int {
        switch self {
        case .section0(let rows): return rows.count
        case .section1(let rows): return rows.count
        case .section2(let rows): return rows.count
        case .section3(let rows): return rows.count
        case .section4(let rows): return rows.count
        case .section5(let rows): return rows.count
        }
    }
    
    func getType(index: Int) -> SettingsPresentationType {
        switch self {
        case .section0(let rows): return rows[index]
        case .section1(let rows): return rows[index]
        case .section2(let rows): return rows[index]
        case .section3(let rows): return rows[index]
        case .section4(let rows): return rows[index]
        case .section5(let rows): return rows[index]
        }
    }
}
