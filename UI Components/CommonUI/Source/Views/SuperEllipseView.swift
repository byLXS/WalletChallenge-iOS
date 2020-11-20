import Foundation
import UIKit

open class SuperEllipseView: UIView {
    
    public var defaultCornerRadius: CGFloat = 14
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        self.superEllipse(cornerRadius: defaultCornerRadius)
    }
}

open class SuperEllipseButton: UIButton {
    
    public var defaultCornerRadius: CGFloat = 14
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        self.superEllipse(cornerRadius: defaultCornerRadius)
    }
}
