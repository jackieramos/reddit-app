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
    @discardableResult
    private static func performRequest<T:Decodable>(route:URLRequestConvertible, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (DataResponse<T, AFError>)->Void) -> DataRequest {

        let request = AF.request(route)
                        .responseDecodable (decoder: decoder){ (response: DataResponse<T, AFError>) in
//                            debugPrint(response)
                            completion(response)
        }
        
        request.cURLDescription(calling: { desc in
//            print(desc)
        })
        return request
    }

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

    static func authorize(completion:@escaping (Result<AuthData, AFError>)->Void) {
        request(route: AuthorizationRouter.authorize, completion: completion)
    }

    static func getSubreddits(after: String, limit: Int, completion:@escaping (Result<SubredditListing, AFError>)->Void) {
        request(route: RedditRouter.getSubredditsListing(after: after, limit: limit), completion: completion)
    }

    static func getPosts(subredditPath: String, completion:@escaping (Result<PostsListing, AFError>)->Void) {
        request(route: RedditRouter.getPostsListing(subredditPath: subredditPath), completion: completion)
    }

    static func searchSubreddit(query: String, completion:@escaping (Result<SubredditListing, AFError>)->Void) {
        request(route: RedditRouter.searchSubreddit(query: query), completion: completion)
    }
}
