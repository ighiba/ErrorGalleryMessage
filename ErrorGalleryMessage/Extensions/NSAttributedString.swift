//
//  NSAttributedString.swift
//  ErrorGalleryMessage
//
//  Created by Ivan Ghiba on 29.06.2025.
//

import UIKit

public extension NSAttributedString {
    static func create(
        text: String,
        font: UIFont,
        foregroundColor: UIColor,
        lineHeight: CGFloat,
        alignment: NSTextAlignment = .left,
        kern: CGFloat = 0.0
    ) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = lineHeight
        paragraphStyle.maximumLineHeight = lineHeight
        paragraphStyle.alignment = alignment
        paragraphStyle.lineBreakMode = .byWordWrapping

        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: foregroundColor,
            .kern: kern, // Figma letter spacing
            .paragraphStyle: paragraphStyle
        ]

        return NSAttributedString(string: text, attributes: attributes)
    }
}
