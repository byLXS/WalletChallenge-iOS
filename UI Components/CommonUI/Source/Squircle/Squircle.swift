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

extension UIBezierPath {

    static func superellipse(in rect: CGRect, cornerRadius: CGFloat) -> UIBezierPath {

        // (Corner radius can't exceed half of the shorter side; correct if
        // necessary:)
        let minSide = min(rect.width, rect.height)
        let radius = min(cornerRadius, minSide/2)

        let topLeft = CGPoint(x: rect.minX, y: rect.minY)
        let topRight = CGPoint(x: rect.maxX, y: rect.minY)
        let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)

        // The two points of the segment along the top side (clockwise):
        let p0 = CGPoint(x: rect.minX + radius, y: rect.minY)
        let p1 = CGPoint(x: rect.maxX - radius, y: rect.minY)

        // The two points of the segment along the right side (clockwise):
        let p2 = CGPoint(x: rect.maxX, y: rect.minY + radius)
        let p3 = CGPoint(x: rect.maxX, y: rect.maxY - radius)

        // The two points of the segment along the bottom side (clockwise):
        let p4 = CGPoint(x: rect.maxX - radius, y: rect.maxY)
        let p5 = CGPoint(x: rect.minX + radius, y: rect.maxY)

        // The two points of the segment along the left side (clockwise):
        let p6 = CGPoint(x: rect.minX, y: rect.maxY - radius)
        let p7 = CGPoint(x: rect.minX, y: rect.minY + radius)

        let path = UIBezierPath()
        path.move(to: p0)
        path.addLine(to: p1)
        path.addCurve(to: p2, controlPoint1: topRight, controlPoint2: topRight)
        path.addLine(to: p3)
        path.addCurve(to: p4, controlPoint1: bottomRight, controlPoint2: bottomRight)
        path.addLine(to: p5)
        path.addCurve(to: p6, controlPoint1: bottomLeft, controlPoint2: bottomLeft)
        path.addLine(to: p7)
        path.addCurve(to: p0, controlPoint1: topLeft, controlPoint2: topLeft)

        return path
    }
}
