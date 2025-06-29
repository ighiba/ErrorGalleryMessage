//
//  UIView.swift
//  ErrorGalleryMessage
//
//  Created by Ivan Ghiba on 29.06.2025.
//

import UIKit

extension UIView {
    func roundCorners(
        topLeft: CGFloat,
        topRight: CGFloat,
        bottomRight: CGFloat,
        bottomLeft: CGFloat
    ) {
        let path = UIBezierPath()
        let bounds = self.bounds
        let width = bounds.width
        let height = bounds.height

        // Start top-left
        path.move(to: CGPoint(x: 0 + topLeft, y: 0))
        path.addLine(to: CGPoint(x: width - topRight, y: 0))
        path.addQuadCurve(to: CGPoint(x: width, y: topRight), controlPoint: CGPoint(x: width, y: 0))
        path.addLine(to: CGPoint(x: width, y: height - bottomRight))
        path.addQuadCurve(to: CGPoint(x: width - bottomRight, y: height), controlPoint: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: bottomLeft, y: height))
        path.addQuadCurve(to: CGPoint(x: 0, y: height - bottomLeft), controlPoint: CGPoint(x: 0, y: height))
        path.addLine(to: CGPoint(x: 0, y: topLeft))
        path.addQuadCurve(to: CGPoint(x: topLeft, y: 0), controlPoint: CGPoint(x: 0, y: 0))
        path.close()

        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }

    func roundCornersWithBorder(
        topLeft: CGFloat,
        topRight: CGFloat,
        bottomRight: CGFloat,
        bottomLeft: CGFloat,
        borderColor: UIColor,
        borderWidth: CGFloat
    ) {
        let path = UIBezierPath()
        let bounds = self.bounds
        let width = bounds.width
        let height = bounds.height

        // Start top-left
        path.move(to: CGPoint(x: 0 + topLeft, y: 0))
        path.addLine(to: CGPoint(x: width - topRight, y: 0))
        path.addQuadCurve(to: CGPoint(x: width, y: topRight), controlPoint: CGPoint(x: width, y: 0))
        path.addLine(to: CGPoint(x: width, y: height - bottomRight))
        path.addQuadCurve(to: CGPoint(x: width - bottomRight, y: height), controlPoint: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: bottomLeft, y: height))
        path.addQuadCurve(to: CGPoint(x: 0, y: height - bottomLeft), controlPoint: CGPoint(x: 0, y: height))
        path.addLine(to: CGPoint(x: 0, y: topLeft))
        path.addQuadCurve(to: CGPoint(x: topLeft, y: 0), controlPoint: CGPoint(x: 0, y: 0))
        path.close()

        // Маска
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask

        // Удаляем старый кастомный бордер, если есть
        layer.sublayers?.removeAll(where: { $0.name == "customBorder" })

        // Бордер
        let border = CAShapeLayer()
        border.path = path.cgPath
        border.strokeColor = borderColor.cgColor
        border.fillColor = UIColor.clear.cgColor
        border.lineWidth = borderWidth
        border.frame = bounds
        border.name = "customBorder"
        layer.addSublayer(border)
    }
    
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
            let path = UIBezierPath()
            let bounds = self.bounds
            let width = bounds.width
            let height = bounds.height

            // Start top-left
            path.move(to: CGPoint(x: 0 + topLeft, y: 0))
            path.addLine(to: CGPoint(x: width - topRight, y: 0))
            path.addQuadCurve(to: CGPoint(x: width, y: topRight), controlPoint: CGPoint(x: width, y: 0))
            path.addLine(to: CGPoint(x: width, y: height - bottomRight))
            path.addQuadCurve(to: CGPoint(x: width - bottomRight, y: height), controlPoint: CGPoint(x: width, y: height))
            path.addLine(to: CGPoint(x: bottomLeft, y: height))
            path.addQuadCurve(to: CGPoint(x: 0, y: height - bottomLeft), controlPoint: CGPoint(x: 0, y: height))
            path.addLine(to: CGPoint(x: 0, y: topLeft))
            path.addQuadCurve(to: CGPoint(x: topLeft, y: 0), controlPoint: CGPoint(x: 0, y: 0))
            path.close()

            layer.shadowColor = UIColor.red.cgColor
            layer.shadowOpacity = 1.0
            layer.shadowOffset = CGSize(width: 20, height: 20)
            layer.shadowRadius = 20
            layer.masksToBounds = false
            layer.shadowPath = path.cgPath
        }
}
