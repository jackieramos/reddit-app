//
//  Subreddit.swift
//  reddit-app
//
//  Created by Jackie Ramos on 02/04/2020.
//  Copyright © 2020 Jackie. All rights reserved.
//

import Foundation

struct Subreddit: Decodable {
    var title: String
    let displayNamePrefixed: String
    let iconImageURL: String?
    let bannerImageURL: String?
    let publicDescription: String
    let subscribersCount: Int?
    let path: String
    
    enum CodingKeys: String, CodingKey {
        case data
        case title
        case displayNamePrefixed = "display_name_prefixed"
        case iconImageURL = "icon_img"
        case bannerImageURL = "banner_background_image"
        case publicDescription = "public_description"
        case subscribersCount = "subscribers"
        case path = "url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)

        title = try data.decode(String.self, forKey: .title)
        displayNamePrefixed = try data.decode(String.self, forKey: .displayNamePrefixed)
        iconImageURL = try data.decode(String?.self, forKey: .iconImageURL)
        bannerImageURL = try data.decode(String?.self, forKey: .bannerImageURL)
        publicDescription = try data.decode(String.self, forKey: .publicDescription)
        subscribersCount = try data.decode(Int?.self, forKey: .subscribersCount)
        path = try data.decode(String.self, forKey: .path)
    }
}


