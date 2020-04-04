//
//  PostTextUrlCellViewModel.swift
//  reddit-app
//
//  Created by Jackie Ramos on 04/04/2020.
//  Copyright © 2020 Jackie. All rights reserved.
//

class PostTextUrlCellViewModel: PostCellViewModelConvertible {
    
    var post: Post

    var url: String {
        return self.post.url
    }
    
    var selftext: String {
        return self.post.selftext
    }
    
    init(post: Post) {
        self.post = post
    }
}

extension PostTextUrlCellViewModel {
    var created: Float {
        return self.post.created
    }
    
    var title: String {
        return self.post.title
    }
    
    var author: String {
        return self.post.author
    }
    
    var type: PostType {
        return self.post.type
    }
}
