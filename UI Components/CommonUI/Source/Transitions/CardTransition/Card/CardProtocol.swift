import Foundation
import UIKit

public protocol CardProtocol {
    func getCardView() -> CardView?
}

public protocol CardPresentedProtocol {
    var finalRect: CGRect { get }
}
