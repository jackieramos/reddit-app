//
//  PostCellViewModelConvertible.swift
//  reddit-app
//
//  Created by Jackie Ramos on 04/04/2020.
//  Copyright © 2020 Jackie. All rights reserved.
//

import Foundation

protocol PostCellViewModelConvertible {
    var post: Post { get }
    var created: Float { get }
    var title: String { get }
    var author: String { get }
    var type: PostType { get }
}
