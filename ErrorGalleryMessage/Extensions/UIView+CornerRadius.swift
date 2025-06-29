//
//  UIView+CornerRadius.swift
//  ErrorGalleryMessage
//
//  Created by Ivan Ghiba on 29.06.2025.
//

import UIKit

public struct ShadowOptions {
    static let dropShadow = ShadowOptions(
        color: .dropShadowColor,
        opacity: 0.12,
        radius: 30,
        offset: CGSize(width: 0, height: 2)
    )
    
    public var color: UIColor
    public var opacity: Float
    public var radius: CGFloat
    public var offset: CGSize
}

public struct CornerRadius {
    static let zero = CornerRadius(topLeft: 0, topRight: 0, bottomRight: 0, bottomLeft: 0)
    
    public var topLeft: CGFloat
    public var topRight: CGFloat
    public var bottomRight: CGFloat
    public var bottomLeft: CGFloat
    
    public init(topLeft: CGFloat, topRight: CGFloat, bottomRight: CGFloat, bottomLeft: CGFloat) {
        self.topLeft = topLeft
        self.topRight = topRight
        self.bottomRight = bottomRight
        self.bottomLeft = bottomLeft
    }
    
    public init(all cornerRadius: CGFloat) {
        self.init(
            topLeft: cornerRadius,
            topRight: cornerRadius,
            bottomRight: cornerRadius,
            bottomLeft: cornerRadius
        )
    }
}

public extension UIView {
    /// Applies rounded corners to the view using CornerRadius struct
    func roundCorners(_ corners: CornerRadius) {
        roundCorners(
            topLeft: corners.topLeft,
            topRight: corners.topRight,
            bottomRight: corners.bottomRight,
            bottomLeft: corners.bottomLeft
        )
    }
    
    /// Applies rounded corners with border using CornerRadius struct
    func roundCornersWithBorder(
        corners: CornerRadius,
        borderColor: UIColor,
        borderWidth: CGFloat
    ) {
        roundCornersWithBorder(
            topLeft: corners.topLeft,
            topRight: corners.topRight,
            bottomRight: corners.bottomRight,
            bottomLeft: corners.bottomLeft,
            borderColor: borderColor,
            borderWidth: borderWidth
        )
    }
    
    /// Applies rounded corners with individual corner radius values
    func roundCorners(
        topLeft: CGFloat,
        topRight: CGFloat,
        bottomRight: CGFloat,
        bottomLeft: CGFloat
    ) {
        let path = customRoundedPath(topLeft: topLeft, topRight: topRight, bottomRight: bottomRight, bottomLeft: bottomLeft)
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }

    /// Applies rounded corners with border using individual corner radius values
    func roundCornersWithBorder(
        topLeft: CGFloat,
        topRight: CGFloat,
        bottomRight: CGFloat,
        bottomLeft: CGFloat,
        borderColor: UIColor,
        borderWidth: CGFloat
    ) {
        let path = customRoundedPath(topLeft: topLeft, topRight: topRight, bottomRight: bottomRight, bottomLeft: bottomLeft)
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
        
        // Delete old border if exists
        layer.sublayers?.removeAll(where: { $0.name == "customBorder" })
        
        let border = CAShapeLayer()
        border.path = path.cgPath
        border.strokeColor = borderColor.cgColor
        border.fillColor = UIColor.clear.cgColor
        border.lineWidth = borderWidth
        border.frame = bounds
        border.name = "customBorder"
        layer.addSublayer(border)
    }
    
    /// Applies custom shadow with rounded corners using CornerRadius struct
    /// Doesn't work with applied round corners
    func applyCustomShadow(
        corners: CornerRadius,
        options: ShadowOptions
    ) {
        applyCustomShadow(
            topLeft: corners.topLeft,
            topRight: corners.topRight,
            bottomRight: corners.bottomRight,
            bottomLeft: corners.bottomLeft,
            shadowColor: options.color,
            shadowOpacity: options.opacity,
            shadowOffset: options.offset,
            shadowRadius: options.radius
        )
    }
    
    /// Applies custom shadow with rounded corners using individual corner radius values
    /// Doesn't work with applied round corners
    func applyCustomShadow(
        topLeft: CGFloat,
        topRight: CGFloat,
        bottomRight: CGFloat,
        bottomLeft: CGFloat,
        shadowColor: UIColor,
        shadowOpacity: Float,
        shadowOffset: CGSize,
        shadowRadius: CGFloat
    ) {
        let path = customRoundedPath(topLeft: topLeft, topRight: topRight, bottomRight: bottomRight, bottomLeft: bottomLeft)
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        layer.masksToBounds = false
        layer.shadowPath = path.cgPath
    }
    
    /// Creates a custom rounded path with individual corner radius values
    private func customRoundedPath(
        topLeft: CGFloat,
        topRight: CGFloat,
        bottomRight: CGFloat,
        bottomLeft: CGFloat
    ) -> UIBezierPath {
        let path = UIBezierPath()
        
        // Start at top-left corner
        path.move(to: CGPoint(x: bounds.minX + topLeft, y: bounds.minY))
        
        // Top edge and top-right corner
        path.addLine(to: CGPoint(x: bounds.maxX - topRight, y: bounds.minY))
        path.addArc(
            withCenter: CGPoint(x: bounds.maxX - topRight, y: bounds.minY + topRight),
            radius: topRight,
            startAngle: -.pi/2,
            endAngle: 0,
            clockwise: true
        )
        
        // Right edge and bottom-right corner
        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY - bottomRight))
        path.addArc(
            withCenter: CGPoint(x: bounds.maxX - bottomRight, y: bounds.maxY - bottomRight),
            radius: bottomRight,
            startAngle: 0,
            endAngle: .pi/2,
            clockwise: true
        )
        
        // Bottom edge and bottom-left corner
        path.addLine(to: CGPoint(x: bounds.minX + bottomLeft, y: bounds.maxY))
        path.addArc(
            withCenter: CGPoint(x: bounds.minX + bottomLeft, y: bounds.maxY - bottomLeft),
            radius: bottomLeft,
            startAngle: .pi/2,
            endAngle: .pi,
            clockwise: true
        )
        
        // Left edge and top-left corner
        path.addLine(to: CGPoint(x: bounds.minX, y: bounds.minY + topLeft))
        path.addArc(
            withCenter: CGPoint(x: bounds.minX + topLeft, y: bounds.minY + topLeft),
            radius: topLeft,
            startAngle: .pi,
            endAngle: -.pi/2,
            clockwise: true
        )
        
        path.close()
        return path
    }
}
