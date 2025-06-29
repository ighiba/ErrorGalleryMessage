//
//  ImageViewContainer.swift
//  ErrorGalleryMessage
//
//  Created by Ivan Ghiba on 29.06.2025.
//

import UIKit

final class ImageViewContainer: ShadowViewContainer {
    var image: UIImage? {
        get { imageView.image }
        set { imageView.image = newValue }
    }
    
    private(set) var imageView: UIImageView
    
    override init(frame: CGRect) {
        self.imageView = UIImageView()
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        self.imageView = UIImageView()
        super.init(coder: coder)
        setup()
    }
    
    override func setup() {
        super.setup()
        contentView.addSubview(imageView)
    }
    
    override func didSetFrame(withValue newValue: CGRect) {
        super.didSetFrame(withValue: newValue)
        imageView.frame = newValue
    }
    
    override func updateFrames() {
        super.updateFrames()
        imageView.frame = bounds
    }
    
    func applyBorder(withRoundCorners corners: CornerRadius, color: UIColor, width: CGFloat) {
        updateFrames()
        imageView.roundCornersWithBorder(
            topLeft: corners.topLeft,
            topRight: corners.topRight,
            bottomRight: corners.bottomRight,
            bottomLeft: corners.bottomLeft,
            borderColor: color,
            borderWidth: width
        )
    }
}
