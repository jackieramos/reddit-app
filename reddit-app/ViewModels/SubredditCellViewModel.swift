//
//  SubredditViewModel.swift
//  reddit-app
//
//  Created by Jackie Ramos on 03/04/2020.
//  Copyright © 2020 Jackie. All rights reserved.
//

import UIKit

class SubredditCellViewModel {
    
    var subreddit: Subreddit!
    var bannerImageURL: String!
    var iconImageURL: String!
    var title: String!
    var description: String!
    var membersCount: String!

    init(subreddit: Subreddit) {
        self.subreddit = subreddit
        self.bannerImageURL = subreddit.bannerImageURL
        self.iconImageURL = subreddit.iconImageURL
        self.title = subreddit.title
        self.description = subreddit.publicDescription
        self.membersCount = "\(subreddit.subscribersCount.abbrv()) members"
    }
}
