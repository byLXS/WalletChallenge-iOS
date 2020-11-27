import UIKit

public struct BarcodeHelper {
    
    public static func generateQRCode(text: String, inputCorrectionLevel level: String = "M") -> UIImage? {
        guard let data = text.data(using: String.Encoding.utf8), let filter = CIFilter(name: "CIQRCodeGenerator", parameters: ["inputMessage": data, "inputCorrectionLevel": level]), let outputImage = filter.outputImage else { return nil }
        
        return UIImage(ciImage: outputImage.transformed(by: CGAffineTransform(scaleX: 10, y: 10)))
    }
    
    public static func generateBarcode(text: String) -> UIImage? {
        guard let data = text.data(using: String.Encoding.utf8), let filter = CIFilter(name: "CICode128BarcodeGenerator", parameters: ["inputMessage": data]), let outputImage = filter.outputImage else { return nil }
        
        return UIImage(ciImage: outputImage.transformed(by: CGAffineTransform(scaleX: 10, y: 10)))
    }
}
