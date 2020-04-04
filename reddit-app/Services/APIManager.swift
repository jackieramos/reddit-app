//
//  APIManager.swift
//  reddit-app
//
//  Created by Jackie Ramos on 02/04/2020.
//  Copyright © 2020 Jackie. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    
    ///Alamofire request
    ///
    /// - Parameters:
    ///   - route: Request route
    @discardableResult
    private static func performRequest<T:Decodable>(route:URLRequestConvertible, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (DataResponse<T, AFError>)->Void) -> DataRequest {

        let request = AF.request(route)
                        .responseDecodable (decoder: decoder){ (response: DataResponse<T, AFError>) in
                            completion(response)
        }
        
        //Comment out to log/print curl
//        request.cURLDescription(calling: { desc in
//            print(desc)
//        })
        return request
    }

    /// Call to Alamofire request to catch 401 error in all endpoints due to Application Only OAuth limitation.
    ///
    /// - Parameters:
    ///   - route: Request route
    @discardableResult
    static func request<T:Decodable>(route:URLRequestConvertible, completion:@escaping (Result<T, AFError>)->Void) -> DataRequest {
        
        performRequest(route: route, completion: { (response: DataResponse<T, AFError>)  in
            
            if response.error == nil {
                completion(response.result)
            } else {
                if response.response?.statusCode == 401 {
                    SessionManager.shared.authorize(completion: { accessToken in
                        self.request(route: route, completion: completion)
                    })
                } else {
                    completion(response.result)
                }
            }
        })
    }

    /// Athorization Request using Application Only OAuth (user-less) - https://github.com/reddit-archive/reddit/wiki/oauth2)
    static func authorize(completion:@escaping (Result<AuthData, AFError>)->Void) {
        request(route: AuthorizationRouter.authorize, completion: completion)
    }

    /// Get subreddits.
    ///
    /// - Parameters:
    ///   - after: Pagination flag for the last listing retrieved (https://www.reddit.com/dev/api/)
    ///   - limit: Subreddits count per listing
    static func getSubreddits(after: String, limit: Int, completion:@escaping (Result<SubredditListing, AFError>)->Void) {
        request(route: RedditRouter.getSubredditsListing(after: after, limit: limit), completion: completion)
    }

    /// Get posts from a subreddit.
    ///
    /// - Parameters:
    ///   - subredditPath: The path used for the subreddit
    ///   - after: Pagination flag for the last listing retrieved (https://www.reddit.com/dev/api/)
    static func getPosts(subredditPath: String, after: String, completion:@escaping (Result<PostsListing, AFError>)->Void) {
        request(route: RedditRouter.getPostsListing(subredditPath: subredditPath, after: after), completion: completion)
    }

    /// Search for subreddits.
    ///
    /// - Parameters:
    ///   - query: The search string
    static func searchSubreddit(query: String, completion:@escaping (Result<SubredditListing, AFError>)->Void) {
        request(route: RedditRouter.searchSubreddit(query: query), completion: completion)
    }
}
