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
    case searchSubreddit(query: String)

    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .getSubredditsListing:
            return .get
        case .getPostsListing:
            return .get
        case .searchSubreddit:
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
        case .searchSubreddit:
            return "/subreddits/search"
        }
    }

    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .getSubredditsListing:
            return nil
        case .getPostsListing(_):
            return nil
        case .searchSubreddit(let query):
            return [K.APIParameterKey.query: query]
        }
    }
}
