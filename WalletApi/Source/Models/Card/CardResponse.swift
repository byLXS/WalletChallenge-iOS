import Foundation
import WalletPresentationData

// MARK: - CardResponse
public struct CardResponse: Codable {
    let number: String
    let kind: String
    let barcode: BarcodeResponse
    let texture: TextureResponse
    let loyaltyCard: LoyaltyCardResponse?
    let issuer: IssuerResponse
    let certificate: CertificateResponse?
}

extension CardResponse {
    func convertResponseInPresentationModel() -> Card {
        let cardType = CardType(rawValue: kind) ?? .none
        switch cardType {
        case .loyalty:
            return LoyaltyCard(number: number, kind: .loyalty, texture: texture.convertResponseInPresentationModel(), barcode: Barcode(number: barcode.number, kind: BarcodeKind(rawValue: barcode.kind) ?? .code128), issuer: Issuer(name: issuer.name, categories: issuer.getCategories()), grade: loyaltyCard?.grade ?? "", balance: loyaltyCard?.balance ?? 0, isFavourites: false, viewsCount: 0)
        case .certificate:
            return CertificateCard(number: number, kind: .certificate, texture: texture.convertResponseInPresentationModel(), barcode: Barcode(number: barcode.number, kind: BarcodeKind(rawValue: barcode.kind) ?? .code128), issuer: Issuer(name: issuer.name, categories: issuer.getCategories()), value: certificate?.value ?? 0, expireDate: certificate?.expireDate ?? "", isFavourites: false, viewsCount: 0)
        case .none:
            return DefaultCard(number: number, kind: .none, texture: texture.convertResponseInPresentationModel(), barcode: Barcode(number: barcode.number, kind: BarcodeKind(rawValue: barcode.kind) ?? .code128), issuer: Issuer(name: issuer.name, categories: issuer.getCategories()), isFavourites: false, viewsCount: 0)
        }
    }
}

extension Array where Element == CardResponse {
    
    public func convertResponseInPresentationData() -> [Card] {
        var models: [Card] = []
        for item in self {
            models.append(item.convertResponseInPresentationModel())
        }
        return models
    }
}

// MARK: - Issuer
public struct IssuerResponse: Codable {
    let name: String
    let categories: [String]?
}

extension IssuerResponse  {
    public func getCategories() -> [CategoryType] {
        var categoryList: [CategoryType] = []
        for category in categories ?? [] {
            categoryList.append(CategoryType(rawValue: category) ?? .unknown)
        }
        return categoryList
    }
}

//enum Category: Codable {
//    case appliances
//    case buildingMaterials
//    case goods
//}

//enum SectionResponseKind: Codable {
//    case certificate
//    case loyalty
//}

// MARK: - LoyaltyCard
public struct LoyaltyCardResponse: Codable {
    let grade: String?
    let balance: Int?
}

//enum Grade: Codable {
//    case gold
//    case platinum
//    case silver
//    case standart
//}

// MARK: - Texture
public struct TextureResponse: Codable {
    let front, back: String
}

extension TextureResponse {
    func convertResponseInPresentationModel() -> Texture {
        return Texture(front: front, back: back)
    }
}
