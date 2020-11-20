import Foundation
import UIKit
import WalletPresentationData
import WalletCore

protocol CardDetailInteractorProtocol {
    var selectedCardSideType: CardSideType { get set }
    func numberOfRowsInSection(section: Int) -> Int
    func getNameCard() -> String
    func loadImage(indexPath: IndexPath, completion: @escaping (UIImage?) -> ())
    func generateBarcode() -> UIImage?
    func getCardDetailItem(indexPath: IndexPath) -> CardDetailItem
    func getCardSideTypes() -> [CardSideType]
    func selectItem(index: Int)
}

class CardDetailInteractor: CardDetailInteractorProtocol {
    
    var card: Card
    
    var cardDetailItems: [CardDetailItem] = []
    
    var selectedCardSideType: CardSideType = .front(path: "")
    
    init(card: Card) {
        self.card = card
        selectedCardSideType = .front(path: card.texture.front)
        setupDisplayItems()
    }
    
    func getNameCard() -> String {
        return card.issuer.name
    }
    
    func setupDisplayItems() {
        switch card.kind {
        case .certificate:
            if let certificateCard = card as? CertificateCard {
                self.cardDetailItems.append(TextDetailItem(type: .certificateValue, value: "\(certificateCard.value)"))
                self.cardDetailItems.append(TextDetailItem(type: .certificateExpireDate, value: "\(certificateCard.expireDate)"))
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
