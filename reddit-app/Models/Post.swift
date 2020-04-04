//
//  Post.swift
//  reddit-app
//
//  Created by Jackie Ramos on 02/04/2020.
//  Copyright © 2020 Jackie. All rights reserved.
//

enum PostType {
    case image
    case link
    case hostedVideo
    case richVideo
    case text
}

struct Post: Decodable {
    let created: Float //created
    let title: String //
    let author: String //author_fullname
    var typeString: String? //post_hint
    
    ///for link  & image type
    var url: String
    
    ///for rich video = from youtube
    var mediaDomainURL: String = "" //secure_media_embed -> media_domain_url
    
    ///for hosted video = own hosted
    var mediaURL: String = "" // media -> scrubber_media_url
    
    ///for text
    var selftext: String // selftext
    
    var type: PostType {
        switch typeString {
        case "image":
            return .image
        case "link":
            return .link
        case "hosted:video":
            return .hostedVideo
        case "rich:video":
            return .richVideo
        default:
            return .text
        }
    }

    enum CodingKeys: String, CodingKey {
        case data
        case created
        case title
        case author = "author_fullname"
        case typeString = "post_hint"
        case url
        case secureMediaEmbed = "secure_media_embed"
        case mediaDomainURL = "media_domain_url"
        case media
        case mediaURL = "scrubber_media_url"
        case selftext
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)

        created = try data.decode(Float.self, forKey: .created)
        title = try data.decode(String.self, forKey: .title)
        author = try data.decode(String.self, forKey: .author)
        
        if let validTypeString = try? data.decode(String?.self, forKey: .typeString) {
            typeString = validTypeString
        }
        
        url = try data.decode(String.self, forKey: .url)

        let secureMediaEmbed = try data.nestedContainer(keyedBy: CodingKeys.self, forKey: .secureMediaEmbed)
        
        if let validMediaDomainURL = try? secureMediaEmbed.decode(String.self, forKey: .mediaDomainURL) {
            mediaDomainURL = validMediaDomainURL
        }

        if let media = try? data.nestedContainer(keyedBy: CodingKeys.self, forKey: .media) {
            if let validMediaURL = try? media.decode(String.self, forKey: .mediaURL) {
                mediaURL = validMediaURL
            }
        }

        selftext = try data.decode(String.self, forKey: .selftext)
    }
}
