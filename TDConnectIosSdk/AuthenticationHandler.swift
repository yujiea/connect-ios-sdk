//
//  BiometricsHandler.swift
//  TDConnectIosSdk
//
//  Created by Lars Solvoll Tønder on 09/11/2018.
//  Copyright © 2018 aerogear. All rights reserved.
//

import LocalAuthentication
import TDConnectIosSdk

enum BiometricTypes: String{
    case face_id = "Face Id"
    case touch_id = "Touch Id"
    case none = "None"
}

class AuthenticationHandler{
    
    static func getAvailableBiometrics() -> BiometricTypes{
        let context = LAContext()
        
        var authError: NSError?
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) else {
            return BiometricTypes.none
        }
        if #available(iOS 11.0, *) {
            let type = context.biometryType
            switch type {
            case LABiometryType.faceID:
                return BiometricTypes.face_id
            case LABiometryType.touchID:
                return BiometricTypes.touch_id
            default:
                return BiometricTypes.none
            }
        }
        return BiometricTypes.touch_id
        
    }
    
    static func authenticate(viewController: UIViewController, useBiometrics: Bool = false, localizedReasonString:String? = NSLocalizedString("please_identify", comment: "Text to be used presented to the user when authenticating with biometrics"),  oauth2Module:OAuth2Module, callback:((_ error:Error?)->Void)?){
        //Use biometrics if available
        if(useBiometrics){
            let newViewController = AuthenticationViewController(nibName:"AuthenticationViewController" , bundle: nil)
            newViewController.callback = callback
            newViewController.oauth2Module = oauth2Module
            newViewController.localizedReasonString = localizedReasonString
            newViewController.cameFrom = viewController
            viewController.present(newViewController, animated: true, completion: nil)
            return
        }
        if oauth2Module.oauth2Session.accessToken != nil {
            callback?(nil)
            return
        }
        
        oauth2Module.requestAccess {(accessToken: AnyObject?, error: NSError?) -> Void in
            guard let accessToken = accessToken else {
                callback?(error)
                return
            }
            callback?(nil)
        }
    }
    
    static func authenticateWithBiometrics(localizedReasonString: String, completion: ((_ error:Error?)->Void)?){
        let context = LAContext()
        
        if #available(iOS 10.0, *) {
            context.localizedCancelTitle = NSLocalizedString("cancel", comment: "Text to be shown on the cancel button")
        }
        
        context.localizedFallbackTitle = NSLocalizedString("use_connect_id", comment: "Text to be shown on the fallback button")
        
        let callbackWrapper: (Error?)->Void = { error in
            guard completion != nil else{
                return
            }
            return completion!(error)
        }
        
        var authError: NSError?
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) else {
            callbackWrapper(authError)
            return
        }
        
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: localizedReasonString) { success, evaluateError in
            guard success else {
                callbackWrapper(evaluateError)
                return
            }
            
            callbackWrapper(nil)
        }
    }
    
    static func authenticateWithConnectId(oauth2Module: OAuth2Module, callback: ((Error?)->Void)?){
        if(oauth2Module.oauth2Session.accessToken != nil) {
            signOut(oauth2Module: oauth2Module, callback: {success,error in
                guard error == nil else {
                    callback?(error)
                    return
                }
                oauth2Module.requestAccess {(accessToken: AnyObject?, error: NSError?) -> Void in
                    guard let accessToken = accessToken else {
                        callback?(error)
                        return
                    }
                    callback?(error)
                    return
                }
            })
            return
        }
        oauth2Module.requestAccess {(accessToken: AnyObject?, error: NSError?) -> Void in
            guard let accessToken = accessToken else {
                print("error=\(String(describing: error))")
                callback?(error)
                return
            }
            print("accessToken=\(accessToken)")
            callback?(error)
            return
        }
    }
    
    static func signOut(oauth2Module:OAuth2Module, callback: ((AnyObject?,NSError?) -> Void)?) {
        oauth2Module.revokeAccess(completionHandler: callback!)
    }
}
