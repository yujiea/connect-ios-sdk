//
//  AboutTextLink.swift
//  TDConnectIosSdk
//
//  Created by Serhii Bovtriuk on 18/10/2019.
//  Copyright © 2019 aerogear. All rights reserved.
//

import UIKit

public class AboutTextLink: UIView {
    
    @IBOutlet var openPopupLabel: UITextView!
    private var textColor: UIColor = UIColor.darkGray
    
    let nibName = "AboutTextLink"
    var contentView: UIView!
    
    public override init(frame: CGRect) {
        // For use in code
        super.init(frame: frame)
        setUpView()
    }

    public required init?(coder aDecoder: NSCoder) {
        // For use in Interface Builder
        super.init(coder: aDecoder)
        setUpView()
    }
    
    public func setTextColor(color: UIColor) {
        self.textColor = color
    }

    private func setUpView() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: self.nibName, bundle: bundle)
        self.contentView = (nib.instantiate(withOwner: self, options: nil).first as! UIView)
        addSubview(contentView)

        // Make a string
        let finalString = NSMutableAttributedString()
        let genericString = NSMutableAttributedString(string: "Your Telenor ID is used to sign in to\nall apps and services.\u{0020}", attributes: [NSAttributedString.Key.font: UIFont(name: "Telenor-Light", size: 12.0)!])
        let learnMoreString = NSMutableAttributedString(string: "Learn more\u{00A0}\u{203A}", attributes: [NSAttributedString.Key.font: UIFont(name: "Telenor-Bold", size: 12.0)!])
        finalString.append(genericString)
        finalString.append(learnMoreString)
        
        // Set the label
        self.openPopupLabel.attributedText = finalString
        self.openPopupLabel.sizeToFit()
        self.openPopupLabel.textColor = self.textColor
        self.openPopupLabel.tintColor = self.textColor
        self.openPopupLabel.isUserInteractionEnabled = true
        self.openPopupLabel.textContainer.lineFragmentPadding = 0
        self.isUserInteractionEnabled = true
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: openPopupLabel.frame.width, height: openPopupLabel.frame.height)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.buttonClick(tap:))))
    }
    
    override public func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let frame = self.bounds
        return frame.contains(point) ? self : nil
    }
    
    @objc private func buttonClick(tap: UITapGestureRecognizer) {
        let range = NSString(string: openPopupLabel.attributedText.string).range(of: "Learn more\u{00A0}\u{203A}")
        if tap.didTapAttributedTextInTextView(textView: openPopupLabel, inRange: range) {
            // Substring tapped
            let window = UIApplication.shared.keyWindow!
            let modalView = AboutModalOverlay(frame: CGRect(x: 0, y: 0, width: window.frame.width, height: window.frame.height))
            window.addSubview(modalView)
        }
    }
}

extension UITapGestureRecognizer {

    func didTapAttributedTextInTextView(textView: UITextView, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: textView.attributedText!)

        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)

        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.maximumNumberOfLines = 2
        let labelSize = textView.bounds.size
        textContainer.size = labelSize

        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: textView)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)

        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)

        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }

}
