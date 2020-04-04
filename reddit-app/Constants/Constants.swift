//
//  Constants.swift
//  reddit-app
//
//  Created by Jackie Ramos on 31/03/2020.
//  Copyright © 2020 Jackie. All rights reserved.
//

import Foundation

struct K {
    struct RedditServer {
        static let baseURL = "https://oauth.reddit.com"
        static let host = "https://www.reddit.com"
        static let apiPath = "/api/v1"
        static let grantTypeValue = "https://oauth.reddit.com/grants/installed_client"
        static let clientId = "mHDswJAmAxSQEg"
    }
    
    struct APIParameterKey {
        static let grantType = "grant_type"
        static let deviceId = "device_id"
        static let query = "q"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
    case formUrlEncoded = "application/x-www-form-urlencoded"
}
