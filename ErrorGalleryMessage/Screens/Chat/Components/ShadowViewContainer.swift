//
//  ShadowViewContainer.swift
//  ErrorGalleryMessage
//
//  Created by Ivan Ghiba on 29.06.2025.
//

import UIKit

public class ShadowViewContainer: UIView {
    private var shadowView = UIView()
    private(set) var contentView = UIView()
    
    override public var frame: CGRect {
        get { super.frame }
        set {
            super.frame = newValue
            didSetFrame(withValue: newValue)
        }
    }
    
    override public init(frame: CGRect) {
        self.shadowView = UIView()
        self.contentView = UIView()
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder: NSCoder) {
        self.shadowView = UIView()
        self.contentView = UIView()
        super.init(coder: coder)
        setup()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        updateFrames()
    }
    
    public func setup() {
        addSubview(shadowView)
        addSubview(contentView)
    }
    
    public func applyRoundCorners(_ corners: CornerRadius) {
        updateFrames()
        contentView.roundCorners(corners)
    }
    
    public func applyShadow(color: UIColor, opacity: Float, width: CGFloat, height: CGFloat, radius: CGFloat) {
        let cornerRadii = CGSize(width: 2, height: 2)
        let shadowPath = UIBezierPath(
            roundedRect: shadowView.bounds,
            byRoundingCorners: [.topLeft, .topRight, .bottomLeft, .bottomRight],
            cornerRadii: cornerRadii
        )
        shadowView.layer.shadowColor = color.cgColor
        shadowView.layer.shadowOpacity = opacity
        shadowView.layer.shadowOffset = CGSize(width: width, height: height)
        shadowView.layer.shadowRadius = radius
        shadowView.layer.shadowPath = shadowPath.cgPath
        shadowView.layer.masksToBounds = false
    }
    
    public func applyShadow(withRoundCorners corners: CornerRadius, options: ShadowOptions) {
        updateFrames()
        shadowView.applyCustomShadow(corners: corners, options: options)
    }
    
    public func didSetFrame(withValue newValue: CGRect) {
        shadowView.frame = newValue
    }
    
    public func updateFrames() {
        shadowView.frame = bounds
        contentView.frame = bounds
    }
}
