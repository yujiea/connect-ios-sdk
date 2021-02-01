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
    var idLocale: IdLocale!
    
    public convenience init(frame: CGRect, idProvider: IdProvider, idLocale: IdLocale) {
        self.init(frame: frame)
        self.idProvider = idProvider
        self.idLocale = idLocale
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
        
        backButton.setTitle(idLocale.aboutBack(), for: .normal);
        backButton.titleLabel?.font = UIFont(name: "Telenor-Regular", size: 18)
        backButton.sizeToFit()
        
        slogan.text = String(idLocale.aboutSlogan())
        slogan.lineBreakMode = .byWordWrapping
        slogan.font = UIFont(name: "Telenor-Light", size: 20)

        title.text = String(idLocale.aboutScreenTitle(idProvider: self.idProvider))
        title.lineBreakMode = .byWordWrapping
        title.font = UIFont(name: "Telenor-Medium", size: 24)
        
        paragraph1.text = String(idLocale.aboutParagraph1(idProvider: self.idProvider))
        paragraph1.lineBreakMode = .byWordWrapping
        paragraph1.font = UIFont(name: "Telenor-Light", size: 16)
        
        paragraph2.text = String(idLocale.aboutParagraph2(idProvider: self.idProvider))
        paragraph2.lineBreakMode = .byWordWrapping
        paragraph2.font = UIFont(name: "Telenor-Light", size: 16)
        
        paragraph3.text = String(idLocale.aboutParagraph3(idProvider: self.idProvider))
        paragraph3.lineBreakMode = .byWordWrapping
        paragraph3.font = UIFont(name: "Telenor-Light", size: 16)
        
        paragraph4.text = String(idLocale.aboutParagraph4(idProvider: self.idProvider))
        paragraph4.lineBreakMode = .byWordWrapping
        paragraph4.font = UIFont(name: "Telenor-Light", size: 16)
        
        paragraph5.text = String(idLocale.aboutParagraph5(idProvider: self.idProvider))
        paragraph5.lineBreakMode = .byWordWrapping
        paragraph5.font = UIFont(name: "Telenor-Light", size: 13)
        
        paragraph6.text = String(idLocale.aboutParagraph6(idProvider: self.idProvider))
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
