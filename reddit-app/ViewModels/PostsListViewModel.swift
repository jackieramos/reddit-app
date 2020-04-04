//
//  PostsListViewModel.swift
//  reddit-app
//
//  Created by Jackie Ramos on 04/04/2020.
//  Copyright © 2020 Jackie. All rights reserved.
//

class PostsListViewModel {
    var postsVM: [PostCellViewModelConvertible] = []
    
    init(posts: [Post]) {
        self.postsVM = posts.map{ post in
            switch post.type {
            case .text, .link, .hostedVideo, .richVideo:
                return PostTextUrlCellViewModel(post: post)
            case .image:
                return PostImageCellViewModel(post: post)
            }
        }
    }
}
