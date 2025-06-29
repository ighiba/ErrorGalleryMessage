//
//  ChatViewController.swift
//  ErrorGalleryMessage
//
//  Created by Ivan Ghiba on 28.06.2025.
//

import UIKit

final class ChatViewController: UIViewController {
    private let backgroundImageView = UIImageView()
    
    private let messageBubbleView = ShadowViewContainer()
    private let imagesContainer = UIView()
    private let mainImageView = ImageViewContainer()
    private let firstSmallImageView = ImageViewContainer()
    private let secondSmallImageView = ImageViewContainer()
    private let messageLabel = UILabel()
    private let timeLabel = UILabel()
    private let errorView = UIView()
    private let errorIcon = UIImageView()
    private let errorLabel = UILabel()
    private let resendButton = ErorrMessageButton(type: .system)
    
    private let bottomInputView = BottomInputView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configure()
    }
    
    private func setup() {
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.frame = view.bounds
        backgroundImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        messageBubbleView.contentView.backgroundColor = .bubbleViewColor
        errorView.backgroundColor = .errorViewColor
        errorIcon.tintColor = .errorTextColor
        bottomInputView.backgroundColor = .white
        resendButton.backgroundColor = .clear
        
        errorView.clipsToBounds = true
        
        timeLabel.numberOfLines = 0
        errorLabel.numberOfLines = 0
        
        view.addSubview(backgroundImageView)
        view.addSubview(messageBubbleView)
        imagesContainer.addSubview(mainImageView)
        imagesContainer.addSubview(firstSmallImageView)
        imagesContainer.addSubview(secondSmallImageView)
        messageBubbleView.contentView.addSubview(imagesContainer)
        messageBubbleView.contentView.addSubview(messageLabel)
        messageBubbleView.contentView.addSubview(timeLabel)
        messageBubbleView.contentView.addSubview(errorView)
        errorView.addSubview(errorIcon)
        errorView.addSubview(errorLabel)
        errorView.addSubview(resendButton)
        
        imagesContainer.bringSubviewToFront(mainImageView)
        
        view.addSubview(bottomInputView)
        
        resendButton.addTarget(self, action: #selector(didPressResendButton), for: .touchUpInside)
    }
    
    private func configure() {
        backgroundImageView.image = UIImage(named: "Images/BackgroundImage")
        mainImageView.image = UIImage(named: "Images/Image1")
        firstSmallImageView.image = UIImage(named: "Images/Image2")
        secondSmallImageView.image = UIImage(named: "Images/Image3")
        errorIcon.image = UIImage(named: "Icons/ErrorIcon")
        
        messageLabel.attributedText = NSAttributedString.create(
            text: "How are you doing? I'm very ok",
            font: .messageLabelFont,
            foregroundColor: .messageTextColor,
            lineHeight: 22,
            kern: 0.0114
        )
        timeLabel.attributedText = NSAttributedString.create(
            text: "12:12",
            font: .timeLabelFont,
            foregroundColor: .timeTextColor,
            lineHeight: 14,
            kern: -0.02
        )
        errorLabel.attributedText = NSAttributedString.create(
            text: "Sending error. The operation could not be completed.",
            font: .errorLabelFont,
            foregroundColor: .errorTextColor,
            lineHeight: 16,
            kern: 0.007
        )
        resendButton.configure(
            labelText: NSAttributedString.create(
                text: "PRESS TO RESEND",
                font: .resendButtonFont,
                foregroundColor: .errorTextColor,
                lineHeight: 14,
                kern: 0.016
            )
        )
        
        messageLabel.addAttribute(.baselineOffset, value: 1)
        timeLabel.addAttribute(.baselineOffset, value: -0.5)
        errorLabel.addAttribute(.baselineOffset, value: 1)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateFrames()
        updateStyle()
    }
    
    private func updateFrames() {
        let bubbleWidth: CGFloat = 300
        let bubbleHeight: CGFloat = 373
        let bubbleX: CGFloat = 128
        let bubbleY: CGFloat = 493
        messageBubbleView.frame = CGRect(x: bubbleX, y: bubbleY, width: bubbleWidth, height: bubbleHeight)
        
        let mainImageSize = CGSize(width: 195, height: 259)
        let smallImageSize = CGSize(width: 96, height: 128)
        
        let imagesContainerOrigin = CGPoint(x: .imageSpacing, y: .imageSpacing)
        let imagesContainerSize = CGSize(width: bubbleWidth - .imageSpacing * 2, height: mainImageSize.height)
        
        imagesContainer.frame = CGRect(origin: imagesContainerOrigin, size: imagesContainerSize)
        
        let smallImageX = mainImageSize.width + .imageSpacing
        let firstSmallImageOrigin = CGPoint(x: smallImageX, y: 0)
        let secondSmallImageOrigin = CGPoint(x: smallImageX, y: smallImageSize.height + .imageSpacing)
        
        mainImageView.frame = CGRect(origin: .zero, size: mainImageSize)
        firstSmallImageView.frame = CGRect(origin: firstSmallImageOrigin, size: smallImageSize)
        secondSmallImageView.frame = CGRect(origin: secondSmallImageOrigin, size: smallImageSize)
            
        let messageLabelX = CGFloat.messageTextHorizontalPadding
        let messageLabelY = imagesContainerOrigin.y + imagesContainerSize.height + .messageTextVerticalPadding
        messageLabel.frame = CGRect(x: messageLabelX, y: messageLabelY, width: 241, height: 22)
        
        let timeLabelSize = CGSize(width: timeLabel.intrinsicContentSize.width, height: 14)
        let timeLabelX = bubbleWidth - .messageTextHorizontalPadding - timeLabelSize.width
        let timeLabelY = messageLabelY + messageLabel.frame.height - timeLabelSize.height
        let timeLabelOrigin = CGPoint(x: timeLabelX, y: timeLabelY)
        timeLabel.frame = CGRect(origin: timeLabelOrigin, size: timeLabelSize)
        
        let errorViewY = bubbleHeight - CGFloat.errorViewHeight
        errorView.frame = CGRect(x: 0, y: errorViewY, width: bubbleWidth, height: .errorViewHeight)
        
        let errorIconX = CGFloat.messageTextHorizontalPadding - 1
        let errorIconY = CGFloat.messageTextVerticalPadding
        let errorIconOrigin = CGPoint(x: errorIconX, y: errorIconY)
        errorIcon.frame = CGRect(origin: errorIconOrigin, size: .errorIconSize)
        
        let errorLabelX = errorIconX + CGSize.errorIconSize.width + .errorHorizontalSpacing
        let errorLabelY = errorIconY
        let errorLabelWidth = bubbleWidth - .errorTextLeftPadding - .messageTextHorizontalPadding
        errorLabel.frame = CGRect(x: errorLabelX, y: errorLabelY, width: errorLabelWidth, height: .errorLabelHeight)
        
        let resendButtonHeight: CGFloat = .errorViewHeight / 2
        let resendButtonY: CGFloat = .errorViewHeight - resendButtonHeight
        resendButton.frame = CGRect(x: 0, y: resendButtonY, width: errorView.frame.width, height: resendButtonHeight)
        resendButton.setLabelLeftPadding(.errorTextLeftPadding)
        
        let bottomInputViewY = view.bounds.height - CGSize.bottomInputViewSize.height
        bottomInputView.frame = CGRect(origin: .init(x: 0, y: bottomInputViewY), size: .bottomInputViewSize)
    }
    
    private func updateStyle() {
        let mainImageCorners = CornerRadius(topLeft: 14, topRight: 2, bottomRight: 2, bottomLeft: 2)
        let firstSmallImageCorners = CornerRadius(topLeft: 2, topRight: 18, bottomRight: 2, bottomLeft: 2)
        let secondSmallImageCorners = CornerRadius(all: 2)
        
        mainImageView.applyBorder(withRoundCorners: mainImageCorners, color: .imageBorderColor, width: 0.5)
        firstSmallImageView.applyBorder(withRoundCorners: firstSmallImageCorners, color: .imageBorderColor, width: 0.5)
        firstSmallImageView.applyShadow(withRoundCorners: firstSmallImageCorners, options: .dropShadow)
        secondSmallImageView.applyBorder(withRoundCorners: secondSmallImageCorners, color: .imageBorderColor, width: 0.5)
        secondSmallImageView.applyShadow(withRoundCorners: secondSmallImageCorners, options: .dropShadow)
        
        let messageBubbleViewCorners = CornerRadius(topLeft: 17, topRight: 21, bottomRight: 2, bottomLeft: 17)
        messageBubbleView.applyRoundCorners(messageBubbleViewCorners)
        messageBubbleView.applyShadow(withRoundCorners: messageBubbleViewCorners, options: .dropShadow)
        
        bottomInputView.applyGradient()
    }
    
    @objc private func didPressResendButton() {
        print("Resend button pressed")
    }
}

private extension CGFloat {
    static let imageSpacing: CGFloat = 3
    static let messageTextHorizontalPadding: CGFloat = 12
    static let messageTextVerticalPadding: CGFloat = 6
    static let errorViewHeight: CGFloat = 76
    static let errorTextLeftPadding: CGFloat = 33
    static let errorHorizontalSpacing: CGFloat = 4
    static let errorLabelHeight: CGFloat = 32
}

private extension CGSize {
    static let errorIconSize = CGSize(width: 18, height: 18)
    static let bottomInputViewSize = CGSize(width: 440, height: 82)
}
