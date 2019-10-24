//
//  IdProvider.swift
//  TDConnectIosSdk
//
//  Created by Serhii Bovtriuk on 29/04/2019.
//  Copyright © 2019 aerogear. All rights reserved.
//

import Foundation

public enum IdProvider {
    
    case connectId, telenorId, gpId
    
    func getName() -> String {
        switch self {
        case .connectId:
            return "CONNECT";
        case .telenorId:
            return "Telenor ID";
        case .gpId:
            return "GP ID";
        }
    }
    
    func getUrl(useStaging: Bool) -> String {
        switch self {
            case .connectId:
                return useStaging ? "https://connect.staging.telenordigital.com/oauth" : "https://connect.telenordigital.com/oauth";
            case .telenorId:
                return useStaging ? "https://signin.telenorid-staging.com/oauth" : "https://signin.telenorid.com/oauth";
            case .gpId:
                return useStaging ? "https://signin.gp-id-staging.com/oauth" : "https://signin.gp-id.com/oauth";
        }
    }
    
}
