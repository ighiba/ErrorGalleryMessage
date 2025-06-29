//
//  BottomInputView.swift
//  ErrorGalleryMessage
//
//  Created by Ivan Ghiba on 29.06.2025.
//

import UIKit

struct GradientConfiguration {
    var startColor: UIColor
    var endColor: UIColor
    var startPoint: CGPoint
    var endPoint: CGPoint
}

final class BottomInputView: UIView {
    private let firstGradientLayer = CAGradientLayer()
    private let secondGradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        firstGradientLayer.frame = bounds
    }
    
    private func setup() {
        secondGradientLayer.opacity = 0.45
        
        layer.addSublayer(firstGradientLayer)
        layer.addSublayer(secondGradientLayer)
    }
    
    func applyGradient() {
        let gradientLayers = [firstGradientLayer, secondGradientLayer]
        let gradientConfigs = [
            GradientConfiguration(
                startColor: .firstGradientStartColor,
                endColor: .firstGradientEndColor,
                startPoint: CGPoint(x: 0, y: 0),
                endPoint: CGPoint(x: 1, y: 1)
            ),
            GradientConfiguration(
                startColor: .secondGradientStartColor,
                endColor: .secondGradientEndColor,
                startPoint: CGPoint(x: 0.5, y: 1),
                endPoint: CGPoint(x: 0.5, y: 0)
            )
        ]
        
        zip(gradientLayers, gradientConfigs).forEach { layer, config in
            layer.frame = bounds
            layer.colors = [config.startColor, config.endColor].map { $0.cgColor }
            layer.startPoint = config.startPoint
            layer.endPoint = config.endPoint
        }
    }
}
