//
//  RedditRouter.swift
//  reddit-app
//
//  Created by Jackie Ramos on 01/04/2020.
//  Copyright © 2020 Jackie. All rights reserved.
//

import Alamofire

enum RedditRouter: URLRequestConvertible, APIConfigurationProtocol {

    case getSubredditsListing
    case getPostsListing(subredditPath: String)

    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .getSubredditsListing:
            return .get
        case .getPostsListing:
            return .get
        }
    }

    // MARK: - Path
    var path: String {
        switch self {
        case .getSubredditsListing:
            return "/subreddits/default"
        case .getPostsListing(let subredditPath):
            return "\(subredditPath)"
        }
    }

    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .getSubredditsListing:
            return nil
        case .getPostsListing(_):
            return nil
        }
    }
}
