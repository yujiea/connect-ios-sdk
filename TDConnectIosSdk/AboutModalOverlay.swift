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
    var idProvider: IdProvider!
    var contentView: UIView!
    
    public convenience init(frame: CGRect, idProvider: IdProvider) {
        self.init(frame: frame)
        self.idProvider = idProvider
        setUpView()
    }
        
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }
    
    private func setUpView() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: self.nibName, bundle: bundle)
        self.contentView = (nib.instantiate(withOwner: self, options: nil).first as! UIView)
        addSubview(contentView)
        
        self.contentView.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width, height: self.frame.height)

        title.text = String(format: "What is %@?", self.idProvider.getName())
        title.lineBreakMode = .byWordWrapping
        title.font = UIFont(name: "Telenor-Bold", size: 24)
        
        subtitle.text = String(format: "With a single %@ you easily access your apps and services.", self.idProvider.getName())
        subtitle.lineBreakMode = .byWordWrapping
        subtitle.font = UIFont(name: "Telenor", size: 17)
        
        contentDescription.text = String(format: "The sign-in process has additional layers of protection, such as verifying your mobile number and email. %@ gives you full control of your personal data, while keeping it safe.", self.idProvider.getName())
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
