//
//  UIView+Squircle.swift
//  Squircle
//
//  Created by Giuseppe Travasoni on 10/04/18.
//

import UIKit
import QuartzCore

extension UIView {
    
    /**
     Apply squircle corner radius.
     */
    public func squircle() {
        self.layer.applySquircle()
    }
}

extension CALayer {
    
    /**
     Apply a squircle mask corner radius.
     */
    public func applySquircle() {
        let maskLayer = CAShapeLayer()
        maskLayer.path = squirclePath.cgPath
        self.mask = maskLayer
    }
}

extension UIView {
    public func superEllipse(cornerRadius: CGFloat) {
        let besierPath = SuperEllipse.superEllipse(forRect: bounds, cornerRadius: cornerRadius)
        let maskLayer = CAShapeLayer()
        maskLayer.path = besierPath.cgPath
        self.layer.mask = maskLayer
    }
    
    public func superEllipse(topRightCornerRadius: CGFloat, bottomRightCornerRadius: CGFloat, bottomLeftCornerRadius: CGFloat, topLeftCornerRadius: CGFloat) {
        let besierPath = SuperEllipse.superEllipse(forRect: bounds, topRightCornerRadius: topRightCornerRadius, bottomRightCornerRadius: bottomRightCornerRadius, bottomLeftCornerRadius: bottomLeftCornerRadius, topLeftCornerRadius: topLeftCornerRadius)
        let maskLayer = CAShapeLayer()
        maskLayer.path = besierPath.cgPath
        self.layer.mask = maskLayer
    }
}

struct SuperEllipse {
    
    static func superEllipse(forRect rect: CGRect, topRightCornerRadius trcr: CGFloat, bottomRightCornerRadius brcr: CGFloat, bottomLeftCornerRadius blcr: CGFloat, topLeftCornerRadius tlcr: CGFloat) -> UIBezierPath {
        let trcr = 1.2 * trcr
        let brcr = 1.2 * brcr
        let blcr = 1.2 * blcr
        let tlcr = 1.2 * tlcr
        
        let path = UIBezierPath()
        
        let topRightStart = CGPoint(x: rect.maxX - trcr, y: rect.minY)
        let topRightAnchor = CGPoint(x: rect.maxX, y: rect.minY)
        let topRightEnd = CGPoint(x: rect.maxX, y: rect.minY + trcr)
        
        let bottomRightStart = CGPoint(x: rect.maxX, y: rect.maxY - brcr)
        let bottomRightAnchor = CGPoint(x: rect.maxX, y: rect.maxY)
        let bottomRightEnd = CGPoint(x: rect.maxX - brcr, y: rect.maxY)
        
        let bottomLeftStart = CGPoint(x: rect.minX + blcr, y: rect.maxY)
        let bottomLeftAnchor = CGPoint(x: rect.minX, y: rect.maxY)
        let bottomLeftEnd = CGPoint(x: rect.minX, y: rect.maxY - blcr)
        
        let topLeftStart = CGPoint(x: rect.minX, y: rect.minY + tlcr)
        let topLeftAnchor = CGPoint(x: rect.minX, y: rect.minY)
        let topLeftEnd = CGPoint(x: rect.minX + tlcr, y: rect.minY)
        
        path.move(to: topRightStart)
        path.addQuadCurve(to: topRightEnd, controlPoint: topRightAnchor)
        path.addLine(to: bottomRightStart)
        path.addQuadCurve(to: bottomRightEnd, controlPoint: bottomRightAnchor)
        path.addLine(to: bottomLeftStart)
        path.addQuadCurve(to: bottomLeftEnd, controlPoint: bottomLeftAnchor)
        path.addLine(to: topLeftStart)
        path.addQuadCurve(to: topLeftEnd, controlPoint: topLeftAnchor)
        path.close()
        
        return path
    }
    
    static func superEllipse(forRect rect: CGRect, cornerRadius cr: CGFloat) -> UIBezierPath {
        return self.superEllipse(forRect: rect, topRightCornerRadius: cr, bottomRightCornerRadius: cr, bottomLeftCornerRadius: cr, topLeftCornerRadius: cr)
    }
    
}
