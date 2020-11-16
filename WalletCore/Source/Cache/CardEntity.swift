import Foundation
import WalletPresentationData
import CoreData

public class CardEntity: NSManagedObject, CDHelperEntity {
    
    public static var entityName: String! { return "CardEntity" }
    
    @NSManaged public var number: String
    @NSManaged public var kind: String
    @NSManaged public var texture: TextureEntity
    @NSManaged public var barcode: BarcodeEntity
    @NSManaged public var loyaltyCard: LoyaltyCardEntity?
    @NSManaged public var certificateCard: CertificateCardEntity?
    
    static public func save(data: [Card], completion: @escaping () -> ()) {
         CDHelper.backgroundContext?.perform({
            _ = data.convertEntityInPresentationData()
            CDHelper.synchronize()
         })
    }
}

extension CardEntity {
    
    public func convertEntityInPresentationData() -> Card {
        let cardType = CardType(rawValue: kind) ?? .none
        switch cardType {
        case .loyalty:
            return LoyaltyCard(number: number, kind: .loyalty, texture: texture.convertEntityInPresentationData(), barcode: barcode.convertEntityInPresentationData(), grade: loyaltyCard?.grade ?? "", balance: Int(truncating: loyaltyCard?.balance ?? 0))
        case .certificate:
            return CertificateCard(number: number, kind: .certificate, texture: texture.convertEntityInPresentationData(), barcode: barcode.convertEntityInPresentationData(), value: certificateCard?.value.intValue ?? 0, expireDate: certificateCard?.expireDate ?? "")
        case .none:
            return DefaultCard(number: number, kind: .none, texture: texture.convertEntityInPresentationData(), barcode: barcode.convertEntityInPresentationData())
        }
    }
}

extension Array where Element == CardEntity {
    
    public func convertEntityInPresentationData() -> [Card] {
        var models: [Card] = []
        for item in self {
            models.append(item.convertEntityInPresentationData())
        }
        return models
    }
}

extension Card {
    
    public func convertResponseInEntity() -> CardEntity {
        let entity = CardEntity.newInBackgroundQueue()
        entity.kind = kind.rawValue
        switch kind {
        case .loyalty:
            let loyaltyCardEntity = LoyaltyCardEntity.newInBackgroundQueue()
            loyaltyCardEntity.grade = (self as? LoyaltyCard)?.grade ?? ""
            loyaltyCardEntity.balance = NSNumber(value: (self as? LoyaltyCard)?.balance ?? 0)
            entity.loyaltyCard = loyaltyCardEntity
        case .certificate:
            let certificateCardEntity = CertificateCardEntity.newInBackgroundQueue()
            certificateCardEntity.expireDate = (self as? CertificateCard)?.expireDate ?? ""
            certificateCardEntity.value = NSNumber(value: (self as? CertificateCard)?.value ?? 0)
            entity.certificateCard = certificateCardEntity
        case .none:
            break
        }
        entity.number = number
        entity.texture = texture.convertResponseInEntity()
        entity.barcode = barcode.convertResponseInEntity()
        return entity
    }
}

extension Array where Element == Card {
    
    public func convertEntityInPresentationData() -> [CardEntity] {
        var models: [CardEntity] = []
        for item in self {
            models.append(item.convertResponseInEntity())
        }
        return models
    }
}
