import Foundation
import UIKit
import WalletPresentationData
import WalletCore

protocol CardDetailInteractorProtocol {
    var selectedCardSideType: CardSideType { get set }
    func numberOfRowsInSection(section: Int) -> Int
    func isFavourites() -> Bool
    func getNameCard() -> String
    func loadImage(indexPath: IndexPath, completion: @escaping (UIImage?) -> ())
    func generateBarcode() -> UIImage?
    func getCardDetailItem(indexPath: IndexPath) -> CardDetailItem
    func getCardSideTypes() -> [CardSideType]
    func selectItem(index: Int)
    func addFavourites()
}

class CardDetailInteractor: CardDetailInteractorProtocol {
    
    var card: Card
    var cardDetailItems: [CardDetailItem] = []
    var selectedCardSideType: CardSideType = .front(path: "")
    var isShowTopBar: Bool
    
    init(card: Card, isShowTopBar: Bool) {
        self.card = card
        self.isShowTopBar = isShowTopBar
        selectedCardSideType = .front(path: card.texture.front)
        setupDisplayItems()
    }
    
    func isFavourites() -> Bool {
        return card.isFavourites
    }
    
    func getNameCard() -> String {
        return card.issuer.name
    }
    
    func setupDisplayItems() {
        switch card.kind {
        case .certificate:
            if let certificateCard = card as? CertificateCard {
                self.cardDetailItems.append(TextDetailItem(type: .certificateValue, value: "\(certificateCard.value)"))
                
                var expireDate = ""
                if let unix = Int(certificateCard.expireDate) {
                    let date = Date(timeIntervalSince1970: TimeInterval(unix))
                    expireDate = date.stringFromDate()
                }
                self.cardDetailItems.append(TextDetailItem(type: .certificateExpireDate, value: expireDate))
            }
            break
        case .loyalty:
            if let loyaltyCard = card as? LoyaltyCard {
                self.cardDetailItems.append(TextDetailItem(type: .loyaltyGrade, value: "\(loyaltyCard.grade)"))
                self.cardDetailItems.append(TextDetailItem(type: .loyaltyBalance, value: "\(loyaltyCard.balance)"))
            }
        case .none:
            break
        }
        
        self.cardDetailItems.append(BarcodeDetailItem(type: .barcode, image: generateBarcode()))
        
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return cardDetailItems.count
    }
    
    func selectItem(index: Int) {
        let item = getCardSideTypes()[index]
        selectedCardSideType = item
    }
    
    func loadImage(indexPath: IndexPath, completion: @escaping (UIImage?) -> ()) {
        if let url = URL(string: getCardSideTypes()[indexPath.row].path) {
            ImageLoader.shared.loadImage(from: url, completion: { (image) in
                DispatchQueue.main.async {
                    completion(image)
                }
            })
        }
    }
    
    func addFavourites() {
        card.isFavourites = !card.isFavourites
        CardEntity.asynchronouslyFind("number=\"\(card.number)\"") { [weak self] (entityList) in
            _ = entityList.map({$0.destroyInBackgroundQueue()})
            let _ = self?.card.convertPresentationDataInEntity()
            CDHelper.synchronize()
        }
    }
    
    func getCardDetailItem(indexPath: IndexPath) -> CardDetailItem {
        return cardDetailItems[indexPath.row]
    }
    
    func getCardSideTypes() -> [CardSideType] {
        let items: [CardSideType] = [.front(path: card.texture.front), .back(path: card.texture.back)]
        return items
    }
    
    func generateBarcode() -> UIImage? {
        let data = card.barcode.number.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CICode128BarcodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 15, y: 15)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
    
    
}
