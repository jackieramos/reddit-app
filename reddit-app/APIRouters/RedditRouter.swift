//
//  RedditRouter.swift
//  reddit-app
//
//  Created by Jackie Ramos on 01/04/2020.
//  Copyright © 2020 Jackie. All rights reserved.
//

import Alamofire

enum RedditRouter: URLRequestConvertible, APIConfigurationProtocol {

    case getSubredditsListing(after: String, limit: Int)
    case getPostsListing(subredditPath: String, after: String)
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
            return "/subreddits"
        case .getPostsListing(let subredditPath, _):
            return "\(subredditPath)"
        case .searchSubreddit:
            return "/subreddits/search"
        }
    }

    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .getSubredditsListing(let after, let limit):
            return [K.APIParameterKey.after: after, K.APIParameterKey.limit: limit]
        case .getPostsListing(_, let after):
            return [K.APIParameterKey.after: after, K.APIParameterKey.limit: 20]
        case .searchSubreddit(let query):
            return [K.APIParameterKey.query: query]
        }
    }
}
