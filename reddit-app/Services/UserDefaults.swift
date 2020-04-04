//
//  UserDefaults.swift
//  reddit-app
//
//  Created by Jackie Ramos on 04/04/2020.
//  Copyright © 2020 Jackie. All rights reserved.
//

import Foundation

extension UserDefaults {
    static var accessToken: String? {
        get {
            return UserDefaults.standard.string(forKey: "com.reddit-app.settings.accessToken")
        }

        set {
            UserDefaults.standard.set(newValue, forKey: "com.reddit-app.settings.accessToken")
            UserDefaults.standard.synchronize()
        }
    }
}

