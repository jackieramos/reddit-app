//
//  AuthData.swift
//  reddit-app
//
//  Created by Jackie Ramos on 02/04/2020.
//  Copyright © 2020 Jackie. All rights reserved.
//

import Foundation

/// Authentication data after App Only OAuth
struct AuthData: Decodable {
    let accessToken: String
    let tokenType: String
    let deviceId: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case deviceId = "device_id"
    }
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        accessToken = try container.decode(String.self, forKey: .accessToken)
//        tokenType = try container.decode(String.self, forKey: .tokenType)
//        deviceId = try container.decode(String.self, forKey: .deviceId)
//    }
}
