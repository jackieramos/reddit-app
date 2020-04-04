//
//  SessionManager.swift
//  reddit-app
//
//  Created by Jackie Ramos on 02/04/2020.
//  Copyright © 2020 Jackie. All rights reserved.
//

import Foundation

class SessionManager: NSObject {

    static let shared = SessionManager()
    
    var authCredentials: [String: String]?

    func authorize(completion: ((String?)->Void)? = nil) {
        APIManager.authorize(completion: { response in
            switch response {
            case .success(let authData):
                UserDefaults.accessToken = authData.accessToken
                completion?(authData.accessToken)
            case .failure(let error):
                print(error.localizedDescription)
                completion?(nil)
            }
        })
    }
}
