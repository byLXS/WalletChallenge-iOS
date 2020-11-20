import Foundation
import UIKit
import WalletPresentationData

enum CardDetailType {
    case loyaltyGrade
    case loyaltyBalance
    case certificateValue
    case certificateExpireDate
    case barcode
    
    var title: String {
        switch self {
        case .loyaltyGrade:
            return Strings.grade
        case .loyaltyBalance:
            return Strings.balance
        case .certificateValue:
            return Strings.value
        case .certificateExpireDate:
            return Strings.expireDate
        case .barcode:
            return ""
        }
    }
}

enum CardSideType: Equatable {
    case front(path: String)
    case back(path: String)
    
    var path: String {
        switch self {
        case .front(let path):
            return path
        case .back(let path):
            return path
        }
    }
    
}

protocol CardDetailItem {
    var type: CardDetailType { get }
}

struct TextDetailItem: CardDetailItem {
    var type: CardDetailType
    let value: String
}


struct BarcodeDetailItem: CardDetailItem {
    var type: CardDetailType = .barcode
    let image: UIImage?
}

