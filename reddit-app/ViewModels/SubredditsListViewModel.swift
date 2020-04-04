//
//  SubredditsListViewModel.swift
//  reddit-app
//
//  Created by Jackie Ramos on 03/04/2020.
//  Copyright © 2020 Jackie. All rights reserved.
//

class SubredditsListViewModel {
    var subredditsVM: [SubredditCellViewModel] = []
    
    init(subreddits: [Subreddit]) {
        self.subredditsVM = subreddits.map{ SubredditCellViewModel(subreddit: $0) }
    }
}
