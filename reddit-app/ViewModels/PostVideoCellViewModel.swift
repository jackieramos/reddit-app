//
//  PostVideoCellViewModel.swift
//  reddit-app
//
//  Created by Jackie Ramos on 04/04/2020.
//  Copyright © 2020 Jackie. All rights reserved.
//

class PostVideoCellViewModel: PostCellViewModelConvertible {
    
    var post: Post

    var mediaDomainURL: String? {
        return self.post.mediaDomainURL
    }
    
    var mediaURL: String? {
        return self.post.mediaURL
    }
    
    init(post: Post) {
        self.post = post
    }
}

extension PostVideoCellViewModel {
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

