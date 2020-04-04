//
//  Listing.swift
//  reddit-app
//
//  Created by Jackie Ramos on 02/04/2020.
//  Copyright © 2020 Jackie. All rights reserved.
//

import Foundation

typealias SubredditListing = Listing<Subreddit>
typealias PostsListing = Listing<Post>

struct Listing<T:Decodable>: Decodable {
    let list: [T]
    let before: String?
    let after: String?

    enum CodingKeys: String, CodingKey {
        case data
        case children
        case before
        case after
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        
        list = try data.decode([T].self, forKey: .children)
        before = try data.decode(String?.self, forKey: .before)
        after = try data.decode(String?.self, forKey: .after)
    }
}
