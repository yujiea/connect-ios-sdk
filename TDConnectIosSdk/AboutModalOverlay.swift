//
//  AboutModalOverlay.swift
//  TDConnectIosSdk
//
//  Created by Serhii Bovtriuk on 15/10/2019.
//  Copyright © 2019 aerogear. All rights reserved.
//

import UIKit

public class AboutModalOverlay: UIView {
    
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var subtitle: UILabel!
    @IBOutlet private weak var contentDescription: UILabel!
    @IBOutlet private weak var closeButton: UIButton!
    
    let nibName = "AboutModalOverlay"
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
    
    // In case if fonts are missing or namings are different
    public func provideFonts(titleFont: UIFont?, subtitleFont: UIFont?, descriptionFont: UIFont?) {
        if (titleFont != nil) {
            title.font = titleFont
        }
        if (subtitleFont != nil) {
            subtitle.font = subtitleFont
        }
        if (descriptionFont != nil) {
            contentDescription.font = descriptionFont
        }
    }
    
    private func setUpView() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: self.nibName, bundle: bundle)
        self.contentView = (nib.instantiate(withOwner: self, options: nil).first as! UIView)
        addSubview(contentView)
        
        self.contentView.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width, height: self.frame.height)
        
        title.text = "What is Telenor ID?"
        title.lineBreakMode = .byWordWrapping
        title.font = UIFont(name: "Telenor-Bold", size: 24)
        
        subtitle.text = "With a single Telenor ID you easily access your apps and services.";
        subtitle.lineBreakMode = .byWordWrapping
        subtitle.font = UIFont(name: "Telenor", size: 17)
        
        contentDescription.text = "The sign-in process has additional layers of protection, such as verifying your mobile number and email. Telenor ID gives you full control of your personal data, while keeping it safe.";
        contentDescription.lineBreakMode = .byWordWrapping
        contentDescription.font = UIFont(name: "Telenor-Light", size: 17)
        
        closeButton.setImage(UIImage(named: "icon-close.png"), for: .normal)
    }
    
    @IBAction func closePopup(_ sender: Any) {
        self.removeFromSuperview()
    }

    
    // Allow view to control itself
    public override func layoutSubviews() {
        // Rounded corners
        self.layoutIfNeeded()
    }
    
    public override func didMoveToSuperview() {
        self.contentView.transform = CGAffineTransform(translationX: 0, y: self.frame.height)
        UIView.animate(withDuration: 0.3, animations: {
            self.contentView.transform = .identity
        })
    }
    
    // Unused for now.
    @objc private func removeSelf() {
        UIView.animate(withDuration: 0.3, animations: {
            self.contentView.transform = CGAffineTransform(translationX: 0, y: self.frame.height)
        }) { _ in
            self.removeFromSuperview()
        }
    }

}
