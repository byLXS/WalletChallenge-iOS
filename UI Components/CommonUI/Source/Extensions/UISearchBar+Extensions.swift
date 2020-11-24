import Foundation
import UIKit
extension UISearchBar {

    public func getTextField() -> UITextField? { return value(forKey: "searchField") as? UITextField }
    public func setText(color: UIColor) { if let textField = getTextField() { textField.textColor = color } }
    public func setPlaceholderText(color: UIColor) { getTextField()?.setPlaceholderText(color: color) }
    public func setClearButton(color: UIColor) { getTextField()?.setClearButton(color: color) }

    public func setTextField(color: UIColor) {
        guard let textField = getTextField() else { return }
        switch searchBarStyle {
        case .minimal:
            textField.layer.backgroundColor = color.cgColor
            textField.layer.cornerRadius = 6
            textField.backgroundColor = color
            
            let backgroundView = textField.subviews.first
            if #available(iOS 13.0, *) {
                backgroundView?.subviews.forEach({ $0.removeFromSuperview() })
            }
            backgroundView?.layer.cornerRadius = 10.5
            backgroundView?.layer.masksToBounds = true
        case .prominent, .default: textField.backgroundColor = color
        @unknown default: break
        }
    }

    public func setSearchImage(color: UIColor) {
        guard let imageView = getTextField()?.leftView as? UIImageView else { return }
        imageView.tintColor = color
        imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
    }
}
