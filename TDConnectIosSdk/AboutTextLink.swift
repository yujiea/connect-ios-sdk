//
//  AboutTextLink.swift
//  TDConnectIosSdk
//
//  Created by Serhii Bovtriuk on 18/10/2019.
//  Copyright © 2019 aerogear. All rights reserved.
//

import UIKit

protocol AtMentionsLabelTapDelegate: class {
  func labelWasTappedForUsername(_ username: String)
}

public class AboutTextLink: UILabel {
    
    @IBOutlet var textlabel: UILabel!

    let nibName = "AboutTextLink"
    var idProvider: IdProvider!
    var contentView: UIView!
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
        
        numberOfLines = 10
        lineBreakMode = NSLineBreakMode.byTruncatingTail
        isUserInteractionEnabled = true
        let finalString = NSMutableAttributedString()
        let genericString = NSMutableAttributedString(string: String(idLocale.aboutDescription(idProvider: self.idProvider)), attributes: [NSAttributedString.Key.font: UIFont(name: "Telenor-Light", size: 12.0)!])
        let learnMoreString = NSMutableAttributedString(string: String(idLocale.aboutLink()), attributes: [NSAttributedString.Key.font: UIFont(name: "Telenor-Bold", size: 12.0)!])

        
        finalString.append(genericString)
        finalString.append(learnMoreString)
        attributedText = finalString

        let tap = UITapGestureRecognizer(target: self, action: #selector(buttonClick(tap:)))
        addGestureRecognizer(tap)
    }
    
    @objc private func buttonClick(tap: UITapGestureRecognizer) {
        let window = UIApplication.shared.keyWindow!
        let modalView = AboutModalOverlay(frame: CGRect(x: 0, y: 0, width: window.frame.width, height: window.frame.height), idProvider: idProvider, idLocale: idLocale)
        window.addSubview(modalView)
    }

}
