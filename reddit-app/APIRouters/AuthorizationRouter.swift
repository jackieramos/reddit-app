//
//  AuthorizationRouter.swift
//  reddit-app
//
//  Created by Jackie Ramos on 01/04/2020.
//  Copyright © 2020 Jackie. All rights reserved.
//

import Foundation
import Alamofire

enum AuthorizationRouter: URLRequestConvertible, APIConfigurationProtocol {

    case authorize

    var url: URL {
        return try! K.RedditServer.authorizationURL.asURL()
    }
    
    var authorizationHeader: String {
        return "Basic \(AuthorizationHelper.generateBasicAuthAuthorizationHeader(username: K.RedditServer.clientId, password: ""))"
    }
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .authorize:
            return .post
        }
    }

    // MARK: - Path
    var path: String {
        switch self {
        case .authorize:
            return "/access_token"
        }
    }

    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .authorize:
            return [K.APIParameterKey.grantType: K.RedditServer.grantTypeValue, K.APIParameterKey.deviceId: AuthorizationHelper.uuid()]
        }
    }
}
