//
//  AuthorizationHelper.swift
//  reddit-app
//
//  Created by Jackie Ramos on 02/04/2020.
//  Copyright © 2020 Jackie. All rights reserved.
//

import Foundation

class AuthorizationHelper {
    
    /// Get Basic Auth header string thru username and password
    ///
    /// - Parameters:
    ///   - username: Basic Auth username
    ///   - password: Basic Auth password
    static func generateBasicAuthAuthorizationHeader(username: String, password: String) -> String {
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        return base64LoginString
    }

    static func uuid() -> String {
        return UUID().uuidString
    }
}

