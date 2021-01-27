//
//  AboutModalOverlay.swift
//  TDConnectIosSdk
//
//  Created by Serhii Bovtriuk on 15/10/2019.
//  Copyright © 2019 aerogear. All rights reserved.
//

import UIKit

public class AboutModalOverlay: UIView {
    
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var slogan: UILabel!
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var paragraph1: UILabel!
    @IBOutlet private weak var paragraph2: UILabel!
    @IBOutlet private weak var paragraph3: UILabel!
    @IBOutlet private weak var paragraph4: UILabel!
    @IBOutlet private weak var paragraph5: UILabel!
    @IBOutlet private weak var paragraph6: UILabel!
    @IBOutlet private weak var insideContentView: UIView!
    @IBOutlet private weak var insideScrollView: UIScrollView!
    @IBOutlet weak var logoImage: UIImageView!
    

    let nibName = "AboutModalOverlay"
    var idProvider: IdProvider!
    var contentView: UIView!
    var scrollView: UIScrollView!
    
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
        self.insideScrollView.contentSize = self.insideContentView.bounds.size;
        
        //insideContentView.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width, height: 300)
        //insideScrollView.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: 200, height: 300)
        
        backButton.setTitle("\u{2039} Back", for: .normal);
        backButton.titleLabel?.font = UIFont(name: "Telenor-Regular", size: 18)
        
        slogan.text = String("One secure login for all services")
        slogan.lineBreakMode = .byWordWrapping
        slogan.font = UIFont(name: "Telenor-Light", size: 20)

        title.text = String(format: "What is %@?", self.idProvider.getName())
        title.lineBreakMode = .byWordWrapping
        title.font = UIFont(name: "Telenor-Medium", size: 24)
        
        paragraph1.text = String(format: "%@ provides all users with a passwordless login to all apps and services.", self.idProvider.getName())
        paragraph1.lineBreakMode = .byWordWrapping
        paragraph1.font = UIFont(name: "Telenor-Light", size: 16)
        
        paragraph2.text = String("Telenor mobile subscribers enjoy additional security and convenience by having their phone numbers automatically recognised and verified by the Telenor mobile network.")
        paragraph2.lineBreakMode = .byWordWrapping
        paragraph2.font = UIFont(name: "Telenor-Light", size: 16)
        
        paragraph3.text = String(format: "With risk-based authentication, %@ ensures user security by detecting unusual logins.", self.idProvider.getName())
        paragraph3.lineBreakMode = .byWordWrapping
        paragraph3.font = UIFont(name: "Telenor-Light", size: 16)
        
        paragraph4.text = String(format: "Unusual logins may just be you traveling to other locations, or someone trying to commit fraud using your %@. In any case, the user will go through one or more extra steps when logging in. This is designed to prevent attempted fraud.", self.idProvider.getName())
        paragraph4.lineBreakMode = .byWordWrapping
        paragraph4.font = UIFont(name: "Telenor-Light", size: 16)
        
        paragraph5.text = String(format: "Anyone can use %@ at no cost, no matter their mobile subscription.", self.idProvider.getName())
        paragraph5.lineBreakMode = .byWordWrapping
        paragraph5.font = UIFont(name: "Telenor-Light", size: 13)
        
        paragraph6.text = String(format: "For higher risk logins, %@ can request a password as an additional step.", self.idProvider.getName())
        paragraph6.lineBreakMode = .byWordWrapping
        paragraph6.font = UIFont(name: "Telenor-Light", size: 13)
        
        
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
