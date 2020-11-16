import Foundation
import UIKit

public protocol NibLoadable: class {
    static var nib: UINib { get }
}

extension NibLoadable {
    public static var nib: UINib {
        return UINib(nibName: name, bundle: Bundle.init(for: self))
    }
    
    public static var name: String {
        return String(describing: self)
    }
}

extension NibLoadable where Self: UIView {
    public static func loadFromNib() -> Self {
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError()
        }
        
        return view
    }
}
