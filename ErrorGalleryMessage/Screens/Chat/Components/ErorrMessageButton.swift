//
//  ErrorMessageButton.swift
//  ErrorGalleryMessage
//
//  Created by Ivan Ghiba on 29.06.2025.
//

import UIKit

final class ErrorMessageButton: UIButton {
    private var defaultBackgroundColor: UIColor?
    private var highlightedBackgroundColor: UIColor? = .white.withAlphaComponent(0.1)
    
    override public var isHighlighted: Bool {
        didSet {
            animateIsHighlightedChange(isHighlighted)
        }
    }
    
    private let label = UILabel()
    private var labelLeftPadding: CGFloat = 33
    
    convenience init(frame: CGRect, labelLeftPadding: CGFloat) {
        self.init(frame: frame)
        self.labelLeftPadding = labelLeftPadding
    }
    
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
        
        let labelHeight: CGFloat = 14
        let labelY = (frame.height - labelHeight) / 2
        label.frame = CGRect(x: labelLeftPadding, y: labelY, width: label.intrinsicContentSize.width, height: labelHeight)
    }
    
    private func setup() {
        addSubview(label)
    }
    
    func configure(labelText: NSAttributedString) {
        label.attributedText = labelText
        setNeedsLayout()
    }
    
    func setLabelLeftPadding(_ padding: CGFloat) {
        labelLeftPadding = padding
        setNeedsLayout()
    }
    
    private func animateIsHighlightedChange(_ newIsHighlighted: Bool) {
        if newIsHighlighted {
            animateColorTransition(duration: 0.01, toColor: highlightedBackgroundColor)
        } else {
            animateColorTransition(duration: 0.9, toColor: defaultBackgroundColor)
        }
    }
    
    private func animateColorTransition(duration: TimeInterval, toColor color: UIColor?) {
        UIView.transition(
            with: self,
            duration: duration,
            options: [.curveEaseOut, .beginFromCurrentState, .allowUserInteraction],
            animations: { self.backgroundColor = color },
            completion: nil
        )
    }
}
