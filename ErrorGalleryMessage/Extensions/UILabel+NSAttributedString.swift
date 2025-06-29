//
//  UILabel+NSAttributedString.swift
//  ErrorGalleryMessage
//
//  Created by Ivan Ghiba on 29.06.2025.
//

import UIKit

extension UILabel {
    func addAttribute(_ attribute: NSAttributedString.Key, value: Any) {
        let attributed: NSMutableAttributedString
        if let existing = self.attributedText {
            attributed = NSMutableAttributedString(attributedString: existing)
        } else if let text = self.text {
            attributed = NSMutableAttributedString(string: text)
        } else {
            return
        }
        attributed.addAttribute(attribute, value: value, range: NSRange(location: 0, length: attributed.length))
        self.attributedText = attributed
    }
}
