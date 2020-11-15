import Foundation
import UIKit
import WalletPresentationData
import WalletCore

protocol CardDetailInteractorProtocol {
    func getCardImage(completion: @escaping (UIImage?) -> ())
    func generateBarcode() -> UIImage? 
}

class CardDetailInteractor: CardDetailInteractorProtocol {
    
    var card: Card
    
    init(card: Card) {
        self.card = card
    }
    
    
    func getCardImage(completion: @escaping (UIImage?) -> ()) {
        guard let url = URL(string: card.texture.front) else { return completion(nil) }
        ImageLoader.shared.loadImage(from: url) { (image) in
            completion(image)
        }
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
