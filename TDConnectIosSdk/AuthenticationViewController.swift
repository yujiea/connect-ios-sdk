//
//  AuthenticationViewController.swift
//  TelenorConnectIosHelloWorld
//
//  Created by Lars Solvoll Tønder on 15/11/2018.
//  Copyright © 2018 Telenor Digital. All rights reserved.
//

import UIKit
import LocalAuthentication

class AuthenticationViewController: UIViewController {
    
    var callback: ((_ error:Error?)->Void)?
    var oauth2Module: OAuth2Module?
    var localizedReasonString: String?
    var cameFrom: UIViewController?
    
    override func viewDidLoad() {
        //Closes the view and calls the callback if there is none, else does nothing
        let callbackWrapper: (Error?)->Void = { error in
            guard self.callback != nil else{
                self.dismiss(animated: true, completion: nil)
                return
            }
            let dismissCallback = {
                self.callback!(error)
            }
            //Ugly hack to support using a webview
            //TODO: find a better way of doing this
            DispatchQueue.main.async {
                let currentController = UIApplication.shared.tdcTopViewController
                //Check if you have already been dismissed and have been sent elsewhere
                if(currentController == self.cameFrom){
                    dismissCallback()
                    return
                }
                self.dismiss(animated: false, completion: dismissCallback)
                return
            }
        }
        
        //Calls the callbackwrapper unless the user chose to use fallback mechanism for logging in
        let biometricsCallback: (Error?)->Void = { error in
            if (error != nil) {
                let laError = error as! LAError
                if ((laError.code) == LAError.userFallback){
                    AuthenticationHandler.authenticateWithConnectId(oauth2Module: self.oauth2Module!, callback: callbackWrapper)
                    return
                }
            }
            callbackWrapper(error)
        }
        
        guard oauth2Module?.oauth2Session.accessToken != nil && AuthenticationHandler.getAvailableBiometrics() != BiometricTypes.none else {
            AuthenticationHandler.authenticateWithConnectId(oauth2Module: self.oauth2Module!, callback: callbackWrapper)
            return
        }
        
        AuthenticationHandler.authenticateWithBiometrics(localizedReasonString: self.localizedReasonString!, completion: biometricsCallback)
        
    }
}
